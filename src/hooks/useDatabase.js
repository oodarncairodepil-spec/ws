import { useState, useEffect, useCallback } from 'react'
import { supabase, dbHelpers } from '../lib/supabase'
import { useGame } from '../context/GameContext'

export const useDatabase = () => {
  const { gameState, updatePlayerStats, updateBuilding, setGameState } = useGame()
  const [isLoading, setIsLoading] = useState(false)
  const [isConnected, setIsConnected] = useState(false)
  const [lastSaved, setLastSaved] = useState(null)
  const [autoSave, setAutoSave] = useState(true)

  // Check database connection
  useEffect(() => {
    const checkConnection = async () => {
      try {
        const { error } = await supabase.from('game_states').select('count').limit(1)
        setIsConnected(!error)
      } catch (err) {
        setIsConnected(false)
        console.error('Database connection failed:', err)
      }
    }
    
    checkConnection()
  }, [])

  // Save current game state to database
  const saveGameState = useCallback(async () => {
    if (!isConnected) {
      console.warn('Cannot save: Database not connected')
      return false
    }

    setIsLoading(true)
    try {
      await dbHelpers.saveGameState({
        id: 'default',
        ...gameState
      })
      setLastSaved(new Date())
      return true
    } catch (error) {
      console.error('Failed to save game state:', error)
      return false
    } finally {
      setIsLoading(false)
    }
  }, [gameState, isConnected])

  // Auto-save game state every 30 seconds if enabled
  useEffect(() => {
    if (!autoSave || !isConnected) return

    const interval = setInterval(() => {
      saveGameState()
    }, 30000) // 30 seconds

    return () => clearInterval(interval)
  }, [autoSave, isConnected, saveGameState])

  // Load game state from database
  const loadGameState = useCallback(async (gameStateId = 'default') => {
    if (!isConnected) {
      console.warn('Cannot load: Database not connected')
      return false
    }

    setIsLoading(true)
    try {
      const savedState = await dbHelpers.loadGameState(gameStateId)
      
      if (savedState) {
        // Update the game context with loaded data
        setGameState({
          player: savedState.player_data,
          buildings: savedState.buildings_data,
          research: savedState.research_data,
          goals: savedState.goals_data
        })
        return true
      }
      return false
    } catch (error) {
      console.error('Failed to load game state:', error)
      return false
    } finally {
      setIsLoading(false)
    }
  }, [isConnected, setGameState])

  // Save strategy to database
  const saveStrategy = useCallback(async (strategy) => {
    if (!isConnected) {
      console.warn('Cannot save strategy: Database not connected')
      return false
    }

    try {
      await dbHelpers.saveStrategy(strategy)
      return true
    } catch (error) {
      console.error('Failed to save strategy:', error)
      return false
    }
  }, [isConnected])

  // Load strategies from database
  const loadStrategies = useCallback(async (category = null) => {
    if (!isConnected) {
      console.warn('Cannot load strategies: Database not connected')
      return []
    }

    try {
      return await dbHelpers.loadStrategies(category)
    } catch (error) {
      console.error('Failed to load strategies:', error)
      return []
    }
  }, [isConnected])

  // Export game data with cloud backup
  const exportGameData = useCallback(async () => {
    const exportData = {
      ...gameState,
      exportDate: new Date().toISOString(),
      cloudBackup: isConnected
    }
    
    // Save to cloud if connected
    if (isConnected) {
      await saveGameState()
    }
    
    // Create downloadable file
    const dataStr = JSON.stringify(exportData, null, 2)
    const dataBlob = new Blob([dataStr], { type: 'application/json' })
    const url = URL.createObjectURL(dataBlob)
    
    const link = document.createElement('a')
    link.href = url
    link.download = `whiteout-survival-backup-${new Date().toISOString().split('T')[0]}.json`
    link.click()
    
    URL.revokeObjectURL(url)
    return true
  }, [gameState, isConnected, saveGameState])

  // Import game data with cloud sync
  const importGameData = useCallback(async (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader()
      reader.onload = async (e) => {
        try {
          const importedData = JSON.parse(e.target.result)
          
          // Update local state
          if (importedData.player) {
            updatePlayerStats(importedData.player)
          }
          
          if (importedData.buildings) {
            importedData.buildings.forEach(building => {
              updateBuilding(building.id, building)
            })
          }
          
          // Save to cloud if connected
          if (isConnected) {
            await saveGameState()
          }
          
          resolve(true)
        } catch (error) {
          console.error('Import failed:', error)
          reject(error)
        }
      }
      reader.readAsText(file)
    })
  }, [isConnected, updatePlayerStats, updateBuilding, saveGameState])

  // Get connection status info
  const getConnectionInfo = useCallback(() => {
    return {
      isConnected,
      isLoading,
      lastSaved,
      autoSave,
      status: isConnected ? 'Connected to Supabase' : 'Offline - Local storage only'
    }
  }, [isConnected, isLoading, lastSaved, autoSave])

  return {
    // Connection status
    isConnected,
    isLoading,
    lastSaved,
    autoSave,
    setAutoSave,
    
    // Core functions
    saveGameState,
    loadGameState,
    saveStrategy,
    loadStrategies,
    
    // Import/Export
    exportGameData,
    importGameData,
    
    // Utilities
    getConnectionInfo
  }
}

export default useDatabase
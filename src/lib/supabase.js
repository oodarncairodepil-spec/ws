import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://qrnkqnporkkylrixzkpl.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFybmtxbnBvcmtreWxyaXh6a3BsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYzODEzMzMsImV4cCI6MjA3MTk1NzMzM30.TFk3CZgu8xryCbZKlo5Gmod-Ni6loQ3BafBrJfAFffQ'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Database table names
export const TABLES = {
  PLAYERS: 'players',
  GAME_STATES: 'game_states',
  BUILDINGS: 'buildings',
  RESOURCES: 'resources',
  STRATEGIES: 'strategies'
}

// Helper functions for database operations
export const dbHelpers = {
  // Save player data
  async savePlayerData(playerData) {
    const { data, error } = await supabase
      .from(TABLES.PLAYERS)
      .upsert(playerData)
      .select()
    
    if (error) {
      console.error('Error saving player data:', error)
      throw error
    }
    return data
  },

  // Load player data
  async loadPlayerData(playerId) {
    const { data, error } = await supabase
      .from(TABLES.PLAYERS)
      .select('*')
      .eq('id', playerId)
      .single()
    
    if (error && error.code !== 'PGRST116') { // PGRST116 = no rows returned
      console.error('Error loading player data:', error)
      throw error
    }
    return data
  },

  // Save complete game state
  async saveGameState(gameState) {
    const { data, error } = await supabase
      .from(TABLES.GAME_STATES)
      .upsert({
        id: gameState.id || 'default',
        player_data: gameState.player,
        buildings_data: gameState.buildings,
        research_data: gameState.research,
        goals_data: gameState.goals,
        updated_at: new Date().toISOString()
      })
      .select()
    
    if (error) {
      console.error('Error saving game state:', error)
      throw error
    }
    return data
  },

  // Load complete game state
  async loadGameState(gameStateId = 'default') {
    const { data, error } = await supabase
      .from(TABLES.GAME_STATES)
      .select('*')
      .eq('id', gameStateId)
      .single()
    
    if (error && error.code !== 'PGRST116') {
      console.error('Error loading game state:', error)
      throw error
    }
    return data
  },

  // Save strategy recommendations
  async saveStrategy(strategy) {
    const { data, error } = await supabase
      .from(TABLES.STRATEGIES)
      .insert({
        title: strategy.title,
        description: strategy.description,
        category: strategy.category,
        priority: strategy.priority,
        requirements: strategy.requirements,
        steps: strategy.steps,
        created_at: new Date().toISOString()
      })
      .select()
    
    if (error) {
      console.error('Error saving strategy:', error)
      throw error
    }
    return data
  },

  // Load strategies
  async loadStrategies(category = null) {
    let query = supabase
      .from(TABLES.STRATEGIES)
      .select('*')
      .order('created_at', { ascending: false })
    
    if (category) {
      query = query.eq('category', category)
    }
    
    const { data, error } = await query
    
    if (error) {
      console.error('Error loading strategies:', error)
      throw error
    }
    return data || []
  }
}
// Database connection test utility
import { supabase, dbHelpers } from '../lib/supabase.js'

// Test database connection
export async function testDatabaseConnection() {
  try {
    console.log('Testing Supabase connection...')
    
    // Test basic connection
    const { error } = await supabase
      .from('resources')
      .select('count')
      .limit(1)
    
    if (error) {
      console.error('Database connection failed:', error)
      return {
        success: false,
        error: error.message,
        details: 'Failed to connect to Supabase database'
      }
    }
    
    console.log('✅ Database connection successful!')
    return {
      success: true,
      message: 'Successfully connected to Supabase database'
    }
  } catch (err) {
    console.error('Connection test error:', err)
    return {
      success: false,
      error: err.message,
      details: 'Unexpected error during connection test'
    }
  }
}

// Test game state operations
export async function testGameStateOperations() {
  try {
    console.log('Testing game state operations...')
    
    // Test save operation
    const testGameState = {
      id: 'test_state',
      player: {
        name: 'Test Player',
        level: 10,
        power: 50000
      },
      buildings: {
        furnace: { level: 15 },
        house: { level: 12 }
      },
      research: {
        construction: { level: 5 }
      },
      goals: []
    }
    
    const saveResult = await dbHelpers.saveGameState(testGameState)
    console.log('✅ Game state save successful:', saveResult)
    
    // Test load operation
    const loadResult = await dbHelpers.loadGameState('test_state')
    console.log('✅ Game state load successful:', loadResult)
    
    return {
      success: true,
      message: 'Game state operations working correctly',
      data: { saveResult, loadResult }
    }
  } catch (err) {
    console.error('Game state test error:', err)
    return {
      success: false,
      error: err.message,
      details: 'Game state operations failed'
    }
  }
}

// Test strategy operations
export async function testStrategyOperations() {
  try {
    console.log('Testing strategy operations...')
    
    // Test save strategy
    const testStrategy = {
      title: 'Test Strategy',
      description: 'This is a test strategy',
      category: 'building',
      priority: 'high',
      requirements: { level: 10 },
      steps: ['Step 1', 'Step 2']
    }
    
    const saveResult = await dbHelpers.saveStrategy(testStrategy)
    console.log('✅ Strategy save successful:', saveResult)
    
    // Test load strategies
    const loadResult = await dbHelpers.loadStrategies('building')
    console.log('✅ Strategy load successful:', loadResult)
    
    return {
      success: true,
      message: 'Strategy operations working correctly',
      data: { saveResult, loadResult }
    }
  } catch (err) {
    console.error('Strategy test error:', err)
    return {
      success: false,
      error: err.message,
      details: 'Strategy operations failed'
    }
  }
}

// Run all tests
export async function runAllDatabaseTests() {
  console.log('🧪 Starting database tests...')
  
  const results = {
    connection: await testDatabaseConnection(),
    gameState: await testGameStateOperations(),
    strategy: await testStrategyOperations()
  }
  
  const allPassed = Object.values(results).every(result => result.success)
  
  console.log('\n📊 Test Results:')
  console.log('Connection Test:', results.connection.success ? '✅ PASS' : '❌ FAIL')
  console.log('Game State Test:', results.gameState.success ? '✅ PASS' : '❌ FAIL')
  console.log('Strategy Test:', results.strategy.success ? '✅ PASS' : '❌ FAIL')
  console.log('\nOverall:', allPassed ? '✅ ALL TESTS PASSED' : '❌ SOME TESTS FAILED')
  
  return {
    success: allPassed,
    results,
    summary: allPassed ? 'All database tests passed successfully' : 'Some database tests failed'
  }
}
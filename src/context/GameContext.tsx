import React, { createContext, useContext, useReducer, ReactNode } from 'react';
import { GameState, PlayerStats, Building, Research, Hero, Goal, Resources, BuildingCategory, ResearchCategory } from '../types/gameData';

interface GameContextType {
  gameState: GameState;
  updatePlayerStats: (stats: Partial<PlayerStats>) => void;
  updateBuilding: (buildingId: string, updates: Partial<Building>) => void;
  updateResearch: (researchId: string, updates: Partial<Research>) => void;
  addGoal: (goal: Goal) => void;
  completeGoal: (goalId: string) => void;
  updateResources: (resources: Partial<Resources>) => void;
  resetGameState: () => void;
  setGameState: (gameState: Partial<GameState>) => void;
}

type GameAction =
  | { type: 'UPDATE_PLAYER_STATS'; payload: Partial<PlayerStats> }
  | { type: 'UPDATE_BUILDING'; payload: { id: string; updates: Partial<Building> } }
  | { type: 'UPDATE_RESEARCH'; payload: { id: string; updates: Partial<Research> } }
  | { type: 'ADD_GOAL'; payload: Goal }
  | { type: 'COMPLETE_GOAL'; payload: string }
  | { type: 'UPDATE_RESOURCES'; payload: Partial<Resources> }
  | { type: 'RESET_GAME_STATE' }
  | { type: 'SET_GAME_STATE'; payload: Partial<GameState> };

const initialGameState: GameState = {
  player: {
    level: 1,
    power: 1000,
    kills: 0,
    deaths: 0,
    resources: {
      meat: 1000,
      wood: 1000,
      iron: 500,
      coal: 300,
      stone: 400,
      gems: 50,
      speedups: {
        construction: 0,
        research: 0,
        training: 0,
        healing: 0
      }
    },
    lastUpdated: new Date()
  },
  buildings: [
    {
      id: 'furnace-1',
      name: 'Furnace',
      level: 1,
      maxLevel: 30,
      upgradeTime: 60,
      upgradeCost: {
        meat: 0,
        wood: 500,
        iron: 200,
        coal: 100,
        stone: 150,
        gems: 0,
        speedups: { construction: 0, research: 0, training: 0, healing: 0 }
      },
      effect: 'Produces meat for your survivors',
      category: BuildingCategory.PRODUCTION
    },
    {
      id: 'lumber-mill-1',
      name: 'Lumber Mill',
      level: 1,
      maxLevel: 30,
      upgradeTime: 45,
      upgradeCost: {
        meat: 300,
        wood: 0,
        iron: 150,
        coal: 80,
        stone: 120,
        gems: 0,
        speedups: { construction: 0, research: 0, training: 0, healing: 0 }
      },
      effect: 'Produces wood for construction',
      category: BuildingCategory.PRODUCTION
    }
  ],
  research: [
    {
      id: 'basic-construction',
      name: 'Basic Construction',
      level: 0,
      maxLevel: 10,
      researchTime: 30,
      researchCost: {
        meat: 200,
        wood: 200,
        iron: 100,
        coal: 50,
        stone: 75,
        gems: 0,
        speedups: { construction: 0, research: 0, training: 0, healing: 0 }
      },
      prerequisites: [],
      effect: 'Reduces construction time by 5% per level',
      category: ResearchCategory.DEVELOPMENT
    }
  ],
  heroes: [],
  goals: [],
  lastSync: new Date()
};

const gameReducer = (state: GameState, action: GameAction): GameState => {
  switch (action.type) {
    case 'UPDATE_PLAYER_STATS':
      return {
        ...state,
        player: {
          ...state.player,
          ...action.payload,
          lastUpdated: new Date()
        },
        lastSync: new Date()
      };

    case 'UPDATE_BUILDING':
      return {
        ...state,
        buildings: state.buildings.map(building =>
          building.id === action.payload.id
            ? { ...building, ...action.payload.updates }
            : building
        ),
        lastSync: new Date()
      };

    case 'UPDATE_RESEARCH':
      return {
        ...state,
        research: state.research.map(research =>
          research.id === action.payload.id
            ? { ...research, ...action.payload.updates }
            : research
        ),
        lastSync: new Date()
      };

    case 'ADD_GOAL':
      return {
        ...state,
        goals: [...state.goals, action.payload],
        lastSync: new Date()
      };

    case 'COMPLETE_GOAL':
      return {
        ...state,
        goals: state.goals.map(goal =>
          goal.id === action.payload
            ? { ...goal, completed: true }
            : goal
        ),
        lastSync: new Date()
      };

    case 'UPDATE_RESOURCES':
      return {
        ...state,
        player: {
          ...state.player,
          resources: {
            ...state.player.resources,
            ...action.payload
          },
          lastUpdated: new Date()
        },
        lastSync: new Date()
      };

    case 'RESET_GAME_STATE':
      return {
        ...initialGameState,
        lastSync: new Date()
      };

    case 'SET_GAME_STATE':
      return {
        ...state,
        ...action.payload,
        lastSync: new Date()
      };

    default:
      return state;
  }
};

const GameContext = createContext<GameContextType | undefined>(undefined);

export const GameProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [gameState, dispatch] = useReducer(gameReducer, initialGameState);

  const updatePlayerStats = (stats: Partial<PlayerStats>) => {
    dispatch({ type: 'UPDATE_PLAYER_STATS', payload: stats });
  };

  const updateBuilding = (buildingId: string, updates: Partial<Building>) => {
    dispatch({ type: 'UPDATE_BUILDING', payload: { id: buildingId, updates } });
  };

  const updateResearch = (researchId: string, updates: Partial<Research>) => {
    dispatch({ type: 'UPDATE_RESEARCH', payload: { id: researchId, updates } });
  };

  const addGoal = (goal: Goal) => {
    dispatch({ type: 'ADD_GOAL', payload: goal });
  };

  const completeGoal = (goalId: string) => {
    dispatch({ type: 'COMPLETE_GOAL', payload: goalId });
  };

  const updateResources = (resources: Partial<Resources>) => {
    dispatch({ type: 'UPDATE_RESOURCES', payload: resources });
  };

  const resetGameState = () => {
    dispatch({ type: 'RESET_GAME_STATE' });
  };

  const setGameState = (gameState: Partial<GameState>) => {
    dispatch({ type: 'SET_GAME_STATE', payload: gameState });
  };

  const value: GameContextType = {
    gameState,
    updatePlayerStats,
    updateBuilding,
    updateResearch,
    addGoal,
    completeGoal,
    updateResources,
    resetGameState,
    setGameState
  };

  return (
    <GameContext.Provider value={value}>
      {children}
    </GameContext.Provider>
  );
};

export const useGame = (): GameContextType => {
  const context = useContext(GameContext);
  if (!context) {
    throw new Error('useGame must be used within a GameProvider');
  }
  return context;
};
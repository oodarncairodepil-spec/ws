// Core game data types for Whiteout Survival

export interface PlayerStats {
  level: number;
  power: number;
  kills: number;
  deaths: number;
  resources: Resources;
  alliance?: string;
  lastUpdated: Date;
}

export interface Resources {
  meat: number;
  wood: number;
  iron: number;
  coal: number;
  stone: number;
  gems: number;
  speedups: {
    construction: number; // in minutes
    research: number;
    training: number;
    healing: number;
  };
}

export interface Building {
  id: string;
  name: string;
  level: number;
  maxLevel: number;
  upgradeTime: number; // in minutes
  upgradeCost: Resources;
  effect: string;
  category: BuildingCategory;
}

export enum BuildingCategory {
  PRODUCTION = 'production',
  MILITARY = 'military',
  RESEARCH = 'research',
  DEFENSE = 'defense',
  UTILITY = 'utility'
}

export interface Research {
  id: string;
  name: string;
  level: number;
  maxLevel: number;
  researchTime: number; // in minutes
  researchCost: Resources;
  prerequisites: string[];
  effect: string;
  category: ResearchCategory;
}

export enum ResearchCategory {
  COMBAT = 'combat',
  ECONOMY = 'economy',
  DEVELOPMENT = 'development',
  SURVIVAL = 'survival'
}

export interface Hero {
  id: string;
  name: string;
  level: number;
  stars: number;
  skills: HeroSkill[];
  equipment: Equipment[];
  power: number;
}

export interface HeroSkill {
  id: string;
  name: string;
  level: number;
  maxLevel: number;
  effect: string;
  cooldown?: number;
}

export interface Equipment {
  id: string;
  name: string;
  type: EquipmentType;
  level: number;
  rarity: EquipmentRarity;
  stats: EquipmentStats;
}

export enum EquipmentType {
  WEAPON = 'weapon',
  ARMOR = 'armor',
  ACCESSORY = 'accessory'
}

export enum EquipmentRarity {
  COMMON = 'common',
  UNCOMMON = 'uncommon',
  RARE = 'rare',
  EPIC = 'epic',
  LEGENDARY = 'legendary'
}

export interface EquipmentStats {
  attack?: number;
  defense?: number;
  health?: number;
  speed?: number;
  criticalRate?: number;
  criticalDamage?: number;
}

export interface GameState {
  player: PlayerStats;
  buildings: Building[];
  research: Research[];
  heroes: Hero[];
  goals: Goal[];
  lastSync: Date;
}

export interface Goal {
  id: string;
  title: string;
  description: string;
  priority: GoalPriority;
  estimatedTime: number; // in minutes
  requiredResources: Resources;
  completed: boolean;
  category: GoalCategory;
}

export enum GoalPriority {
  LOW = 'low',
  MEDIUM = 'medium',
  HIGH = 'high',
  CRITICAL = 'critical'
}

export enum GoalCategory {
  BUILDING = 'building',
  RESEARCH = 'research',
  HERO = 'hero',
  RESOURCE = 'resource',
  COMBAT = 'combat'
}

export interface StrategyRecommendation {
  id: string;
  title: string;
  description: string;
  priority: number;
  estimatedBenefit: string;
  timeToComplete: number;
  requiredResources: Resources;
  steps: string[];
  category: GoalCategory;
}

export interface CalculationResult {
  type: string;
  result: number | string;
  explanation: string;
  recommendations: StrategyRecommendation[];
}
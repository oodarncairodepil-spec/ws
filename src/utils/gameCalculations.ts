import { Resources, Building, Research, PlayerStats, StrategyRecommendation, GoalCategory, GoalPriority } from '../types/gameData';

// Resource calculation utilities
export const calculateResourceProduction = (buildings: Building[]): Resources => {
  const baseProduction: Resources = {
    meat: 0,
    wood: 0,
    iron: 0,
    coal: 0,
    stone: 0,
    gems: 0,
    speedups: {
      construction: 0,
      research: 0,
      training: 0,
      healing: 0
    }
  };

  buildings.forEach(building => {
    // Production rates based on building type and level
    switch (building.name.toLowerCase()) {
      case 'furnace':
        baseProduction.meat += building.level * 100;
        break;
      case 'lumber mill':
        baseProduction.wood += building.level * 80;
        break;
      case 'iron mine':
        baseProduction.iron += building.level * 60;
        break;
      case 'coal mine':
        baseProduction.coal += building.level * 40;
        break;
      case 'stone quarry':
        baseProduction.stone += building.level * 50;
        break;
    }
  });

  return baseProduction;
};

export const calculateUpgradeTime = (building: Building, research: Research[]): number => {
  let baseTime = building.upgradeTime;
  
  // Apply research bonuses
  research.forEach(tech => {
    if (tech.category === 'development' && tech.name.includes('Construction')) {
      baseTime *= (1 - (tech.level * 0.05)); // 5% reduction per level
    }
  });

  return Math.max(baseTime, 1); // Minimum 1 minute
};

export const calculateResourceNeeded = (current: Resources, required: Resources): Resources => {
  return {
    meat: Math.max(0, required.meat - current.meat),
    wood: Math.max(0, required.wood - current.wood),
    iron: Math.max(0, required.iron - current.iron),
    coal: Math.max(0, required.coal - current.coal),
    stone: Math.max(0, required.stone - current.stone),
    gems: Math.max(0, required.gems - current.gems),
    speedups: {
      construction: Math.max(0, required.speedups.construction - current.speedups.construction),
      research: Math.max(0, required.speedups.research - current.speedups.research),
      training: Math.max(0, required.speedups.training - current.speedups.training),
      healing: Math.max(0, required.speedups.healing - current.speedups.healing)
    }
  };
};

export const calculateTimeToGather = (needed: Resources, production: Resources): number => {
  const times: number[] = [];
  
  if (needed.meat > 0 && production.meat > 0) {
    times.push(needed.meat / production.meat);
  }
  if (needed.wood > 0 && production.wood > 0) {
    times.push(needed.wood / production.wood);
  }
  if (needed.iron > 0 && production.iron > 0) {
    times.push(needed.iron / production.iron);
  }
  if (needed.coal > 0 && production.coal > 0) {
    times.push(needed.coal / production.coal);
  }
  if (needed.stone > 0 && production.stone > 0) {
    times.push(needed.stone / production.stone);
  }

  return times.length > 0 ? Math.max(...times) : 0;
};

export const calculatePowerGain = (building: Building): number => {
  // Power calculation based on building type and level
  const basePower = {
    'furnace': 50,
    'lumber mill': 40,
    'iron mine': 60,
    'coal mine': 45,
    'stone quarry': 55,
    'barracks': 100,
    'hospital': 80,
    'research lab': 120,
    'wall': 200
  };

  const buildingKey = building.name.toLowerCase() as keyof typeof basePower;
  const base = basePower[buildingKey] || 30;
  
  return base * building.level * 1.2; // 20% bonus per level
};

export const generateOptimizationRecommendations = (
  playerStats: PlayerStats,
  buildings: Building[],
  research: Research[]
): StrategyRecommendation[] => {
  const recommendations: StrategyRecommendation[] = [];
  const production = calculateResourceProduction(buildings);

  // Check for resource bottlenecks
  const resourceRatios = {
    meat: playerStats.resources.meat / (production.meat || 1),
    wood: playerStats.resources.wood / (production.wood || 1),
    iron: playerStats.resources.iron / (production.iron || 1),
    coal: playerStats.resources.coal / (production.coal || 1),
    stone: playerStats.resources.stone / (production.stone || 1)
  };

  // Find the lowest ratio (biggest bottleneck)
  const bottleneck = Object.entries(resourceRatios).reduce((min, [resource, ratio]) => 
    ratio < min.ratio ? { resource, ratio } : min,
    { resource: 'meat', ratio: Infinity }
  );

  if (bottleneck.ratio < 24) { // Less than 24 hours of resources
    recommendations.push({
      id: `boost-${bottleneck.resource}`,
      title: `Increase ${bottleneck.resource.charAt(0).toUpperCase() + bottleneck.resource.slice(1)} Production`,
      description: `Your ${bottleneck.resource} production is low. Consider upgrading related buildings.`,
      priority: 8,
      estimatedBenefit: `+${Math.floor(production[bottleneck.resource as keyof typeof production] as number * 0.2)}/hour`,
      timeToComplete: 120,
      requiredResources: {
        meat: 1000,
        wood: 1000,
        iron: 500,
        coal: 300,
        stone: 400,
        gems: 0,
        speedups: { construction: 0, research: 0, training: 0, healing: 0 }
      },
      steps: [
        `Identify ${bottleneck.resource} production buildings`,
        'Check upgrade requirements',
        'Gather necessary resources',
        'Upgrade the building'
      ],
      category: GoalCategory.BUILDING
    });
  }

  // Check for research opportunities
  const incompleteResearch = research.filter(r => r.level < r.maxLevel);
  if (incompleteResearch.length > 0) {
    const priorityResearch = incompleteResearch.find(r => r.category === 'economy') || incompleteResearch[0];
    
    recommendations.push({
      id: `research-${priorityResearch.id}`,
      title: `Continue ${priorityResearch.name} Research`,
      description: `Advancing ${priorityResearch.name} will provide significant benefits to your gameplay.`,
      priority: 7,
      estimatedBenefit: priorityResearch.effect,
      timeToComplete: priorityResearch.researchTime,
      requiredResources: priorityResearch.researchCost,
      steps: [
        'Ensure Research Lab is available',
        'Gather required resources',
        'Start research',
        'Use speedups if needed'
      ],
      category: GoalCategory.RESEARCH
    });
  }

  // Power optimization
  if (playerStats.power < 100000) {
    recommendations.push({
      id: 'power-boost',
      title: 'Focus on Power Growth',
      description: 'Your power is relatively low. Focus on building upgrades and hero development.',
      priority: 6,
      estimatedBenefit: '+10,000 Power',
      timeToComplete: 240,
      requiredResources: {
        meat: 5000,
        wood: 5000,
        iron: 3000,
        coal: 2000,
        stone: 2500,
        gems: 100,
        speedups: { construction: 60, research: 30, training: 0, healing: 0 }
      },
      steps: [
        'Upgrade key buildings (Furnace, Research Lab)',
        'Level up heroes',
        'Complete research projects',
        'Enhance equipment'
      ],
      category: GoalCategory.BUILDING
    });
  }

  return recommendations.sort((a, b) => b.priority - a.priority);
};

export const formatTime = (minutes: number): string => {
  if (minutes < 60) {
    return `${Math.round(minutes)}m`;
  } else if (minutes < 1440) {
    const hours = Math.floor(minutes / 60);
    const mins = Math.round(minutes % 60);
    return mins > 0 ? `${hours}h ${mins}m` : `${hours}h`;
  } else {
    const days = Math.floor(minutes / 1440);
    const hours = Math.floor((minutes % 1440) / 60);
    return hours > 0 ? `${days}d ${hours}h` : `${days}d`;
  }
};

export const formatNumber = (num: number): string => {
  if (num >= 1000000) {
    return `${(num / 1000000).toFixed(1)}M`;
  } else if (num >= 1000) {
    return `${(num / 1000).toFixed(1)}K`;
  }
  return num.toString();
};
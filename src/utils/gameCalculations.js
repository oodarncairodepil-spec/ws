// Game calculations and optimization engine for Whiteout Survival

// Resource calculation constants
const RESOURCE_MULTIPLIERS = {
  meat: 1.2,
  wood: 1.15,
  iron: 1.3,
  coal: 1.4,
  stone: 1.25,
  gems: 2.0
};

const BUILDING_BASE_COSTS = {
  'furnace': { meat: 0, wood: 500, iron: 200, coal: 100, stone: 150, gems: 0 },
  'lumber-mill': { meat: 300, wood: 0, iron: 150, coal: 80, stone: 120, gems: 0 },
  'iron-mine': { meat: 400, wood: 600, iron: 0, coal: 200, stone: 300, gems: 0 },
  'coal-mine': { meat: 500, wood: 700, iron: 300, coal: 0, stone: 400, gems: 0 },
  'quarry': { meat: 350, wood: 500, iron: 250, coal: 150, stone: 0, gems: 0 },
  'barracks': { meat: 800, wood: 1000, iron: 600, coal: 300, stone: 500, gems: 10 },
  'hospital': { meat: 600, wood: 800, iron: 400, coal: 200, stone: 350, gems: 5 },
  'research-center': { meat: 1000, wood: 1200, iron: 800, coal: 500, stone: 700, gems: 20 }
};

const RESEARCH_BASE_COSTS = {
  'basic-construction': { meat: 200, wood: 200, iron: 100, coal: 50, stone: 75, gems: 0 },
  'advanced-construction': { meat: 500, wood: 500, iron: 300, coal: 150, stone: 200, gems: 5 },
  'resource-efficiency': { meat: 400, wood: 400, iron: 200, coal: 100, stone: 150, gems: 3 },
  'combat-training': { meat: 800, wood: 600, iron: 500, coal: 200, stone: 300, gems: 10 },
  'survival-tactics': { meat: 600, wood: 500, iron: 400, coal: 150, stone: 250, gems: 8 }
};

// Utility functions
export const formatNumber = (num) => {
  if (num >= 1000000) {
    return (num / 1000000).toFixed(1) + 'M';
  } else if (num >= 1000) {
    return (num / 1000).toFixed(1) + 'K';
  }
  return num.toString();
};

export const formatTime = (minutes) => {
  if (minutes < 60) {
    return `${minutes}m`;
  } else if (minutes < 1440) {
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return mins > 0 ? `${hours}h ${mins}m` : `${hours}h`;
  } else {
    const days = Math.floor(minutes / 1440);
    const hours = Math.floor((minutes % 1440) / 60);
    return hours > 0 ? `${days}d ${hours}h` : `${days}d`;
  }
};

export const formatPercentage = (value, decimals = 1) => {
  return `${(value * 100).toFixed(decimals)}%`;
};

// Building upgrade calculations
export const calculateUpgradeCost = (buildingType, currentLevel, targetLevel = null) => {
  const baseCosts = BUILDING_BASE_COSTS[buildingType.toLowerCase()] || BUILDING_BASE_COSTS['furnace'];
  const level = targetLevel || currentLevel + 1;
  
  const upgradeCost = {};
  Object.keys(baseCosts).forEach(resource => {
    const multiplier = RESOURCE_MULTIPLIERS[resource] || 1.2;
    upgradeCost[resource] = Math.floor(baseCosts[resource] * Math.pow(multiplier, level - 1));
  });
  
  return upgradeCost;
};

export const calculateUpgradeTime = (buildingType, currentLevel, targetLevel = null) => {
  const level = targetLevel || currentLevel + 1;
  const baseTime = 30; // 30 minutes base
  return Math.floor(baseTime * Math.pow(1.3, level - 1));
};

export const calculateBuildingPowerGain = (buildingType, currentLevel, targetLevel = null) => {
  const level = targetLevel || currentLevel + 1;
  const basePower = {
    'furnace': 50,
    'lumber-mill': 45,
    'iron-mine': 60,
    'coal-mine': 65,
    'quarry': 55,
    'barracks': 100,
    'hospital': 80,
    'research-center': 120
  };
  
  const base = basePower[buildingType.toLowerCase()] || 50;
  return Math.floor(base * Math.pow(1.15, level - 1));
};

// Research calculations
export const calculateResearchCost = (researchType, currentLevel, targetLevel = null) => {
  const baseCosts = RESEARCH_BASE_COSTS[researchType.toLowerCase()] || RESEARCH_BASE_COSTS['basic-construction'];
  const level = targetLevel || currentLevel + 1;
  
  const researchCost = {};
  Object.keys(baseCosts).forEach(resource => {
    const multiplier = RESOURCE_MULTIPLIERS[resource] || 1.2;
    researchCost[resource] = Math.floor(baseCosts[resource] * Math.pow(multiplier, level - 1));
  });
  
  return researchCost;
};

export const calculateResearchTime = (researchType, currentLevel, targetLevel = null) => {
  const level = targetLevel || currentLevel + 1;
  const baseTime = 20; // 20 minutes base
  return Math.floor(baseTime * Math.pow(1.4, level - 1));
};

// Resource production calculations
export const calculateResourceProduction = (buildings) => {
  const production = {
    meat: 0,
    wood: 0,
    iron: 0,
    coal: 0,
    stone: 0,
    gems: 0
  };
  
  buildings.forEach(building => {
    const baseProduction = {
      'furnace': { meat: 100 },
      'lumber-mill': { wood: 80 },
      'iron-mine': { iron: 60 },
      'coal-mine': { coal: 50 },
      'quarry': { stone: 70 }
    };
    
    const buildingProduction = baseProduction[building.name.toLowerCase().replace(' ', '-')];
    if (buildingProduction) {
      Object.keys(buildingProduction).forEach(resource => {
        const baseAmount = buildingProduction[resource];
        const levelMultiplier = Math.pow(1.1, building.level - 1);
        production[resource] += Math.floor(baseAmount * levelMultiplier);
      });
    }
  });
  
  return production;
};

// Power calculation
export const calculateTotalPower = (player, buildings, research) => {
  let totalPower = player.power || 0;
  
  // Add building power
  buildings.forEach(building => {
    totalPower += calculateBuildingPowerGain(building.name, building.level);
  });
  
  // Add research power
  research.forEach(tech => {
    const basePower = 30;
    totalPower += Math.floor(basePower * Math.pow(1.2, tech.level));
  });
  
  return totalPower;
};

// Resource efficiency calculations
export const calculateResourceEfficiency = (currentResources, dailyProduction, dailyConsumption) => {
  const efficiency = {};
  
  Object.keys(currentResources).forEach(resource => {
    if (resource === 'speedups') return;
    
    const production = dailyProduction[resource] || 0;
    const consumption = dailyConsumption[resource] || 0;
    const current = currentResources[resource] || 0;
    
    const netGain = production - consumption;
    const daysRemaining = netGain > 0 ? Infinity : (current / Math.abs(netGain));
    
    efficiency[resource] = {
      production,
      consumption,
      netGain,
      daysRemaining: isFinite(daysRemaining) ? daysRemaining : null,
      status: netGain > 0 ? 'surplus' : netGain < 0 ? 'deficit' : 'balanced'
    };
  });
  
  return efficiency;
};

// Optimization recommendations
export const generateOptimizationRecommendations = (player, buildings, research) => {
  const recommendations = [];
  const currentProduction = calculateResourceProduction(buildings);
  
  // Building upgrade recommendations
  buildings.forEach(building => {
    if (building.level < building.maxLevel) {
      const upgradeCost = calculateUpgradeCost(building.name, building.level);
      const powerGain = calculateBuildingPowerGain(building.name, building.level);
      const upgradeTime = calculateUpgradeTime(building.name, building.level);
      
      // Check if player can afford the upgrade
      const canAfford = Object.keys(upgradeCost).every(resource => {
        if (resource === 'speedups') return true;
        return (player.resources[resource] || 0) >= upgradeCost[resource];
      });
      
      const priority = calculateUpgradePriority(building, upgradeCost, powerGain, canAfford);
      
      recommendations.push({
        id: `upgrade-${building.id}`,
        title: `Upgrade ${building.name} to Level ${building.level + 1}`,
        description: `Increase ${building.name} efficiency and power output`,
        category: 'building',
        priority,
        estimatedBenefit: `+${formatNumber(powerGain)} Power`,
        timeToComplete: upgradeTime,
        requiredResources: upgradeCost,
        steps: [
          `Gather required resources: ${formatResourceList(upgradeCost)}`,
          `Start ${building.name} upgrade`,
          `Wait ${formatTime(upgradeTime)} for completion`,
          `Enjoy increased production and power`
        ],
        canAfford,
        powerGain
      });
    }
  });
  
  // Research recommendations
  research.forEach(tech => {
    if (tech.level < tech.maxLevel) {
      const researchCost = calculateResearchCost(tech.name, tech.level);
      const researchTime = calculateResearchTime(tech.name, tech.level);
      
      const canAfford = Object.keys(researchCost).every(resource => {
        if (resource === 'speedups') return true;
        return (player.resources[resource] || 0) >= researchCost[resource];
      });
      
      const priority = calculateResearchPriority(tech, researchCost, canAfford);
      
      recommendations.push({
        id: `research-${tech.id}`,
        title: `Research ${tech.name} Level ${tech.level + 1}`,
        description: tech.effect,
        category: 'research',
        priority,
        estimatedBenefit: 'Improved efficiency',
        timeToComplete: researchTime,
        requiredResources: researchCost,
        steps: [
          `Gather required resources: ${formatResourceList(researchCost)}`,
          `Start ${tech.name} research`,
          `Wait ${formatTime(researchTime)} for completion`,
          `Apply research benefits`
        ],
        canAfford
      });
    }
  });
  
  // Resource management recommendations
  const resourceRecommendations = generateResourceRecommendations(player, currentProduction);
  recommendations.push(...resourceRecommendations);
  
  // Sort by priority and affordability
  return recommendations.sort((a, b) => {
    if (a.canAfford !== b.canAfford) {
      return a.canAfford ? -1 : 1;
    }
    return b.priority - a.priority;
  });
};

// Helper functions for recommendations
const calculateUpgradePriority = (building, cost, powerGain, canAfford) => {
  let priority = 50; // Base priority
  
  // Higher priority for production buildings
  if (['furnace', 'lumber-mill', 'iron-mine', 'coal-mine', 'quarry'].includes(building.name.toLowerCase().replace(' ', '-'))) {
    priority += 20;
  }
  
  // Higher priority for lower level buildings (easier upgrades)
  priority += Math.max(0, 10 - building.level);
  
  // Higher priority for better power-to-cost ratio
  const totalCost = Object.values(cost).reduce((sum, val) => sum + (typeof val === 'number' ? val : 0), 0);
  const efficiency = powerGain / (totalCost || 1);
  priority += Math.min(20, efficiency * 10);
  
  // Bonus for affordable upgrades
  if (canAfford) {
    priority += 15;
  }
  
  return Math.round(priority);
};

const calculateResearchPriority = (tech, cost, canAfford) => {
  let priority = 40; // Base priority
  
  // Higher priority for development research
  if (tech.category === 'development') {
    priority += 15;
  }
  
  // Higher priority for lower level research
  priority += Math.max(0, 8 - tech.level);
  
  // Bonus for affordable research
  if (canAfford) {
    priority += 10;
  }
  
  return Math.round(priority);
};

const generateResourceRecommendations = (player, production) => {
  const recommendations = [];
  const resources = player.resources;
  
  // Check for resource shortages
  Object.keys(resources).forEach(resource => {
    if (resource === 'speedups') return;
    
    const current = resources[resource];
    const dailyProduction = production[resource] || 0;
    
    // Low resource warning
    if (current < dailyProduction * 0.5) {
      recommendations.push({
        id: `resource-${resource}`,
        title: `Low ${resource.charAt(0).toUpperCase() + resource.slice(1)} Warning`,
        description: `Your ${resource} reserves are running low. Consider focusing on ${resource} production.`,
        category: 'resource',
        priority: 70,
        estimatedBenefit: 'Prevent resource shortage',
        timeToComplete: 60,
        requiredResources: {},
        steps: [
          `Upgrade ${resource} production buildings`,
          `Reduce ${resource} consumption`,
          `Consider trading for ${resource}`,
          `Use speedups to accelerate production`
        ],
        canAfford: true
      });
    }
  });
  
  return recommendations;
};

const formatResourceList = (resources) => {
  return Object.entries(resources)
    .filter(([resource, amount]) => resource !== 'speedups' && amount > 0)
    .map(([resource, amount]) => `${formatNumber(amount)} ${resource}`)
    .join(', ');
};

// Advanced calculations
export const calculateOptimalUpgradeSequence = (player, buildings, maxUpgrades = 5) => {
  const sequence = [];
  let currentResources = { ...player.resources };
  
  for (let i = 0; i < maxUpgrades; i++) {
    let bestUpgrade = null;
    let bestScore = 0;
    
    buildings.forEach(building => {
      if (building.level >= building.maxLevel) return;
      
      const cost = calculateUpgradeCost(building.name, building.level);
      const powerGain = calculateBuildingPowerGain(building.name, building.level);
      
      // Check if affordable
      const canAfford = Object.keys(cost).every(resource => {
        if (resource === 'speedups') return true;
        return (currentResources[resource] || 0) >= cost[resource];
      });
      
      if (!canAfford) return;
      
      // Calculate score based on power gain and cost efficiency
      const totalCost = Object.values(cost).reduce((sum, val) => sum + (typeof val === 'number' ? val : 0), 0);
      const score = powerGain / (totalCost || 1);
      
      if (score > bestScore) {
        bestScore = score;
        bestUpgrade = {
          building,
          cost,
          powerGain,
          score
        };
      }
    });
    
    if (!bestUpgrade) break;
    
    // Add to sequence and deduct resources
    sequence.push(bestUpgrade);
    Object.keys(bestUpgrade.cost).forEach(resource => {
      if (resource !== 'speedups') {
        currentResources[resource] = (currentResources[resource] || 0) - bestUpgrade.cost[resource];
      }
    });
    
    // Update building level for next iteration
    bestUpgrade.building.level += 1;
  }
  
  return sequence;
};

export const calculateSpeedupValue = (timeMinutes, speedupType = 'construction') => {
  const gemValues = {
    construction: 1, // 1 gem per minute
    research: 1.2,
    training: 0.8,
    healing: 0.6
  };
  
  return Math.ceil(timeMinutes * (gemValues[speedupType] || 1));
};

export const calculateROI = (investment, benefit, timeHours) => {
  const hourlyReturn = benefit / timeHours;
  const roi = (hourlyReturn / investment) * 100;
  return {
    hourlyReturn,
    roi,
    paybackTime: investment / hourlyReturn
  };
};
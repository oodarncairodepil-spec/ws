import React, { useState } from 'react';
import { useGame } from '../context/GameContext';
import { formatNumber, formatTime, calculateUpgradeTime, calculateBuildingPowerGain } from '../utils/gameCalculations';

const BuildingManager = () => {
  const { gameState, updateBuilding } = useGame();
  const { player, buildings, research } = gameState;
  const [selectedBuilding, setSelectedBuilding] = useState(null);

  const BuildingCard = ({ building }) => {
    const upgradeTime = calculateUpgradeTime(building, research);
    const powerGain = calculateBuildingPowerGain(building.name, building.level);
    const canAfford = Object.entries(building.upgradeCost).every(([resource, cost]) => {
      if (resource === 'speedups') return true;
      return player.resources[resource] >= cost;
    });

    return (
      <div className="card">
        <div className="flex items-start justify-between mb-3">
          <div className="flex-1">
            <div className="flex items-center space-x-2 mb-1">
              <h3 className="font-semibold text-white">{building.name}</h3>
              <span className="bg-blue-600 text-white text-xs px-2 py-1 rounded">
                Lv.{building.level}
              </span>
            </div>
            <p className="text-gray-400 text-sm mb-2">{building.effect}</p>
            <div className="flex items-center space-x-4 text-xs text-gray-500">
              <span>⚡ +{formatNumber(powerGain)} Power</span>
              <span>⏱️ {formatTime(upgradeTime)}</span>
            </div>
          </div>
          <button
            onClick={() => setSelectedBuilding(building)}
            className="btn-primary text-xs px-3 py-1"
          >
            Details
          </button>
        </div>

        {/* Progress Bar */}
        <div className="mb-3">
          <div className="flex justify-between text-xs text-gray-400 mb-1">
            <span>Level Progress</span>
            <span>{building.level}/{building.maxLevel}</span>
          </div>
          <div className="w-full bg-gray-700 rounded-full h-2">
            <div
              className="bg-blue-600 h-2 rounded-full"
              style={{ width: `${(building.level / building.maxLevel) * 100}%` }}
            ></div>
          </div>
        </div>

        {/* Upgrade Cost Preview */}
        <div className="grid grid-cols-3 gap-2 mb-3">
          {Object.entries(building.upgradeCost).slice(0, 3).map(([resource, cost]) => {
            if (resource === 'speedups' || cost === 0) return null;
            const current = player.resources[resource];
            const hasEnough = current >= cost;
            
            return (
              <div key={resource} className="text-center">
                <div className={`text-xs ${hasEnough ? 'text-green-400' : 'text-red-400'}`}>
                  {formatNumber(cost)}
                </div>
                <div className="text-xs text-gray-500 capitalize">{resource}</div>
              </div>
            );
          }).filter(Boolean)}
        </div>

        {/* Action Buttons */}
        <div className="flex space-x-2">
          <button
            onClick={() => handleUpgrade(building.id)}
            disabled={!canAfford || building.level >= building.maxLevel}
            className={`flex-1 py-2 px-3 rounded-lg text-sm font-medium transition-colors ${
              canAfford && building.level < building.maxLevel
                ? 'bg-green-600 hover:bg-green-700 text-white'
                : 'bg-gray-600 text-gray-400 cursor-not-allowed'
            }`}
          >
            {building.level >= building.maxLevel ? 'Max Level' : canAfford ? 'Upgrade' : 'Insufficient Resources'}
          </button>
        </div>
      </div>
    );
  };

  const handleUpgrade = (buildingId) => {
    const building = buildings.find(b => b.id === buildingId);
    if (!building || building.level >= building.maxLevel) return;

    // Check if player has enough resources
    const canAfford = Object.entries(building.upgradeCost).every(([resource, cost]) => {
      if (resource === 'speedups') return true;
      return player.resources[resource] >= cost;
    });

    if (canAfford) {
      // Deduct resources
      const newResources = { ...player.resources };
      Object.entries(building.upgradeCost).forEach(([resource, cost]) => {
        if (resource !== 'speedups' && cost > 0) {
          newResources[resource] -= cost;
        }
      });

      // Update building level
      updateBuilding(buildingId, { level: building.level + 1 });
      
      // Update resources (this would need to be implemented in the context)
      // updateResources(newResources);
    }
  };

  const getBuildingsByCategory = () => {
    const categories = {};
    buildings.forEach(building => {
      if (!categories[building.category]) {
        categories[building.category] = [];
      }
      categories[building.category].push(building);
    });
    return categories;
  };

  const categoryIcons = {
    production: '🏭',
    military: '⚔️',
    research: '🔬',
    defense: '🛡️',
    utility: '🔧'
  };

  const buildingCategories = getBuildingsByCategory();

  return (
    <div className="p-4 space-y-6">
      {/* Building Overview */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Building Management</h2>
        
        {/* Summary Stats */}
        <div className="grid grid-cols-3 gap-4 mb-6">
          <div className="card text-center">
            <div className="text-2xl font-bold text-blue-400">{buildings.length}</div>
            <div className="text-gray-400 text-sm">Total Buildings</div>
          </div>
          <div className="card text-center">
            <div className="text-2xl font-bold text-green-400">
              {Math.round(buildings.reduce((sum, b) => sum + b.level, 0) / buildings.length)}
            </div>
            <div className="text-gray-400 text-sm">Avg Level</div>
          </div>
          <div className="card text-center">
            <div className="text-2xl font-bold text-yellow-400">
              {formatNumber(buildings.reduce((sum, b) => sum + calculateBuildingPowerGain(b.name, b.level), 0))}
            </div>
            <div className="text-gray-400 text-sm">Total Power</div>
          </div>
        </div>

        {/* Buildings by Category */}
        {Object.entries(buildingCategories).map(([category, categoryBuildings]) => (
          <div key={category} className="mb-6">
            <h3 className="text-md font-semibold mb-3 text-white flex items-center space-x-2">
              <span>{categoryIcons[category] || '🏢'}</span>
              <span className="capitalize">{category} Buildings</span>
              <span className="text-gray-400 text-sm">({categoryBuildings.length})</span>
            </h3>
            <div className="space-y-3">
              {categoryBuildings.map(building => (
                <BuildingCard key={building.id} building={building} />
              ))}
            </div>
          </div>
        ))}
      </section>

      {/* Building Detail Modal */}
      {selectedBuilding && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
          <div className="bg-gray-800 rounded-lg p-6 max-w-md w-full max-h-[80vh] overflow-y-auto">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-lg font-semibold text-white">{selectedBuilding.name}</h3>
              <button
                onClick={() => setSelectedBuilding(null)}
                className="text-gray-400 hover:text-white"
              >
                ✕
              </button>
            </div>

            <div className="space-y-4">
              {/* Current Stats */}
              <div>
                <h4 className="font-semibold text-blue-400 mb-2">Current Stats</h4>
                <div className="bg-gray-700 rounded-lg p-3 space-y-2">
                  <div className="flex justify-between">
                    <span className="text-gray-400">Level:</span>
                    <span className="text-white">{selectedBuilding.level}/{selectedBuilding.maxLevel}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-gray-400">Power:</span>
                    <span className="text-yellow-400">+{formatNumber(calculateBuildingPowerGain(selectedBuilding.name, selectedBuilding.level))}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-gray-400">Upgrade Time:</span>
                    <span className="text-blue-400">{formatTime(calculateUpgradeTime(selectedBuilding, research))}</span>
                  </div>
                </div>
              </div>

              {/* Upgrade Cost */}
              <div>
                <h4 className="font-semibold text-blue-400 mb-2">Upgrade Cost</h4>
                <div className="bg-gray-700 rounded-lg p-3 space-y-2">
                  {Object.entries(selectedBuilding.upgradeCost).map(([resource, cost]) => {
                    if (resource === 'speedups' || cost === 0) return null;
                    const current = player.resources[resource];
                    const hasEnough = current >= cost;
                    
                    return (
                      <div key={resource} className="flex justify-between">
                        <span className="text-gray-400 capitalize">{resource}:</span>
                        <span className={hasEnough ? 'text-green-400' : 'text-red-400'}>
                          {formatNumber(cost)} ({formatNumber(current)} available)
                        </span>
                      </div>
                    );
                  }).filter(Boolean)}
                </div>
              </div>

              {/* Effect Description */}
              <div>
                <h4 className="font-semibold text-blue-400 mb-2">Effect</h4>
                <p className="text-gray-300 text-sm bg-gray-700 rounded-lg p-3">
                  {selectedBuilding.effect}
                </p>
              </div>

              {/* Action Buttons */}
              <div className="flex space-x-3">
                <button
                  onClick={() => {
                    handleUpgrade(selectedBuilding.id);
                    setSelectedBuilding(null);
                  }}
                  disabled={selectedBuilding.level >= selectedBuilding.maxLevel}
                  className="flex-1 btn-primary"
                >
                  {selectedBuilding.level >= selectedBuilding.maxLevel ? 'Max Level' : 'Upgrade'}
                </button>
                <button
                  onClick={() => setSelectedBuilding(null)}
                  className="flex-1 btn-secondary"
                >
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Quick Upgrade Recommendations */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Upgrade Recommendations</h2>
        <div className="card">
          <div className="space-y-3">
            {buildings
              .filter(b => b.level < b.maxLevel)
              .sort((a, b) => calculateBuildingPowerGain(b.name, b.level) - calculateBuildingPowerGain(a.name, a.level))
              .slice(0, 3)
              .map(building => {
                const powerGain = calculateBuildingPowerGain(building.name, building.level);
                const upgradeTime = calculateUpgradeTime(building, research);
                
                return (
                  <div key={building.id} className="flex justify-between items-center">
                    <div>
                      <div className="font-semibold text-white">{building.name}</div>
                      <div className="text-gray-400 text-sm">
                        Lv.{building.level} → {building.level + 1}
                      </div>
                    </div>
                    <div className="text-right">
                      <div className="text-yellow-400 text-sm">+{formatNumber(powerGain)} Power</div>
                      <div className="text-blue-400 text-xs">{formatTime(upgradeTime)}</div>
                    </div>
                  </div>
                );
              })}
          </div>
        </div>
      </section>
    </div>
  );
};

export default BuildingManager;
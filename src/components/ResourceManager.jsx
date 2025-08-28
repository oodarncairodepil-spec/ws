import React, { useState } from 'react';
import { useGame } from '../context/GameContext';
import { formatNumber, formatTime, calculateResourceProduction } from '../utils/gameCalculations';

const ResourceManager = () => {
  const { gameState, updateResources } = useGame();
  const { player, buildings } = gameState;
  const [targetResources, setTargetResources] = useState({
    meat: 0,
    wood: 0,
    iron: 0,
    coal: 0,
    stone: 0,
    gems: 0
  });

  const production = calculateResourceProduction(buildings);

  const ResourceInput = ({ name, icon, current, production, target, onChange }) => (
    <div className="card">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center space-x-2">
          <span className="text-2xl">{icon}</span>
          <div>
            <h3 className="font-semibold text-white">{name}</h3>
            <p className="text-gray-400 text-sm">Current: {formatNumber(current)}</p>
          </div>
        </div>
        <div className="text-right">
          <p className="text-green-400 text-sm">+{formatNumber(production)}/hr</p>
          <p className="text-gray-500 text-xs">
            {production > 0 ? `${formatTime((1000000 - current) / production * 60)} to 1M` : 'No production'}
          </p>
        </div>
      </div>
      
      <div className="space-y-2">
        <label className="block text-sm text-gray-400">Target Amount:</label>
        <input
          type="number"
          value={target}
          onChange={(e) => onChange(name.toLowerCase(), parseInt(e.target.value) || 0)}
          className="input-field w-full"
          placeholder="Enter target amount"
        />
        {target > current && production > 0 && (
          <p className="text-blue-400 text-sm">
            Time needed: {formatTime((target - current) / production * 60)}
          </p>
        )}
      </div>
    </div>
  );

  const SpeedupCard = ({ type, icon, current }) => (
    <div className="bg-gray-800 rounded-lg p-3 border border-gray-700">
      <div className="flex items-center justify-between">
        <div className="flex items-center space-x-2">
          <span className="text-lg">{icon}</span>
          <span className="text-white text-sm capitalize">{type}</span>
        </div>
        <span className="text-blue-400 font-semibold">{formatTime(current)}</span>
      </div>
    </div>
  );

  const handleTargetChange = (resource, value) => {
    setTargetResources(prev => ({
      ...prev,
      [resource]: value
    }));
  };

  const handleQuickUpdate = (resource, amount) => {
    const newResources = {
      ...player.resources,
      [resource]: Math.max(0, player.resources[resource] + amount)
    };
    updateResources(newResources);
  };

  const calculateTotalTime = () => {
    const times = [];
    Object.entries(targetResources).forEach(([resource, target]) => {
      if (target > player.resources[resource]) {
        const needed = target - player.resources[resource];
        const prod = production[resource] || 0;
        if (prod > 0) {
          times.push(needed / prod * 60);
        }
      }
    });
    return times.length > 0 ? Math.max(...times) : 0;
  };

  const resources = [
    { name: 'Meat', icon: '🥩', key: 'meat' },
    { name: 'Wood', icon: '🪵', key: 'wood' },
    { name: 'Iron', icon: '⚙️', key: 'iron' },
    { name: 'Coal', icon: '⚫', key: 'coal' },
    { name: 'Stone', icon: '🪨', key: 'stone' },
    { name: 'Gems', icon: '💎', key: 'gems' }
  ];

  return (
    <div className="p-4 space-y-6">
      {/* Resource Overview */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Resource Management</h2>
        <div className="space-y-4">
          {resources.map(resource => (
            <ResourceInput
              key={resource.key}
              name={resource.name}
              icon={resource.icon}
              current={player.resources[resource.key]}
              production={production[resource.key] || 0}
              target={targetResources[resource.key]}
              onChange={handleTargetChange}
            />
          ))}
        </div>
      </section>

      {/* Target Summary */}
      {Object.values(targetResources).some(v => v > 0) && (
        <section>
          <h2 className="text-lg font-semibold mb-4 text-blue-400">Target Summary</h2>
          <div className="card">
            <div className="space-y-3">
              <div className="flex justify-between items-center">
                <span className="text-gray-400">Total time needed:</span>
                <span className="text-yellow-400 font-semibold">{formatTime(calculateTotalTime())}</span>
              </div>
              
              {Object.entries(targetResources).map(([resource, target]) => {
                if (target > player.resources[resource]) {
                  const needed = target - player.resources[resource];
                  const prod = production[resource] || 0;
                  return (
                    <div key={resource} className="flex justify-between items-center text-sm">
                      <span className="text-gray-400 capitalize">{resource} needed:</span>
                      <div className="text-right">
                        <div className="text-white">{formatNumber(needed)}</div>
                        {prod > 0 && (
                          <div className="text-blue-400 text-xs">{formatTime(needed / prod * 60)}</div>
                        )}
                      </div>
                    </div>
                  );
                }
                return null;
              }).filter(Boolean)}
            </div>
          </div>
        </section>
      )}

      {/* Speedups */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Speedups</h2>
        <div className="grid grid-cols-2 gap-3">
          <SpeedupCard
            type="construction"
            icon="🏗️"
            current={player.resources.speedups.construction}
          />
          <SpeedupCard
            type="research"
            icon="🔬"
            current={player.resources.speedups.research}
          />
          <SpeedupCard
            type="training"
            icon="⚔️"
            current={player.resources.speedups.training}
          />
          <SpeedupCard
            type="healing"
            icon="❤️"
            current={player.resources.speedups.healing}
          />
        </div>
      </section>

      {/* Quick Actions */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Quick Updates</h2>
        <div className="grid grid-cols-3 gap-2">
          {resources.slice(0, 5).map(resource => (
            <div key={resource.key} className="space-y-2">
              <p className="text-center text-sm text-gray-400">{resource.icon} {resource.name}</p>
              <div className="flex space-x-1">
                <button
                  onClick={() => handleQuickUpdate(resource.key, -1000)}
                  className="btn-secondary text-xs px-2 py-1 flex-1"
                >
                  -1K
                </button>
                <button
                  onClick={() => handleQuickUpdate(resource.key, 1000)}
                  className="btn-primary text-xs px-2 py-1 flex-1"
                >
                  +1K
                </button>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Production Efficiency */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Production Efficiency</h2>
        <div className="card">
          <div className="space-y-3">
            {resources.slice(0, 5).map(resource => {
              const current = player.resources[resource.key];
              const prod = production[resource.key] || 0;
              const hoursOfProduction = prod > 0 ? current / prod : 0;
              
              return (
                <div key={resource.key} className="flex justify-between items-center">
                  <span className="text-gray-400">{resource.icon} {resource.name}:</span>
                  <div className="text-right">
                    <div className="text-white text-sm">
                      {hoursOfProduction > 0 ? `${hoursOfProduction.toFixed(1)}h stored` : 'No production'}
                    </div>
                    <div className={`text-xs ${
                      hoursOfProduction > 24 ? 'text-green-400' :
                      hoursOfProduction > 12 ? 'text-yellow-400' : 'text-red-400'
                    }`}>
                      {hoursOfProduction > 48 ? 'Excellent' :
                       hoursOfProduction > 24 ? 'Good' :
                       hoursOfProduction > 12 ? 'Fair' : 'Low'}
                    </div>
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

export default ResourceManager;
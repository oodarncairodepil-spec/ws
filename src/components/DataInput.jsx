import React, { useState } from 'react';
import { useGame } from '../context/GameContext';
import { useDatabase } from '../hooks/useDatabase';
import DatabaseStatus from './DatabaseStatus';

const DataInput = () => {
  const { gameState, updatePlayerStats, updateResources, updateBuilding, resetGameState } = useGame();
  const { importGameData, exportGameData } = useDatabase();
  const { player, buildings } = gameState;
  const [activeSection, setActiveSection] = useState('player');
  const [formData, setFormData] = useState({
    player: {
      level: player.level,
      power: player.power,
      kills: player.kills,
      deaths: player.deaths,
      alliance: player.alliance || ''
    },
    resources: { ...player.resources }
  });

  const sections = [
    { id: 'player', name: 'Player Stats', icon: '👤' },
    { id: 'resources', name: 'Resources', icon: '📦' },
    { id: 'buildings', name: 'Buildings', icon: '🏗️' },
    { id: 'import', name: 'Import/Export', icon: '📁' }
  ];

  const handleInputChange = (section, field, value) => {
    setFormData(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value
      }
    }));
  };

  const handleResourceChange = (resource, value) => {
    setFormData(prev => ({
      ...prev,
      resources: {
        ...prev.resources,
        [resource]: parseInt(value) || 0
      }
    }));
  };

  const handleSpeedupChange = (type, value) => {
    setFormData(prev => ({
      ...prev,
      resources: {
        ...prev.resources,
        speedups: {
          ...prev.resources.speedups,
          [type]: parseInt(value) || 0
        }
      }
    }));
  };

  const handleSavePlayerStats = () => {
    updatePlayerStats(formData.player);
    alert('Player stats updated successfully!');
  };

  const handleSaveResources = () => {
    updateResources(formData.resources);
    alert('Resources updated successfully!');
  };

  const handleBuildingLevelChange = (buildingId, newLevel) => {
    updateBuilding(buildingId, { level: parseInt(newLevel) || 1 });
  };

  const handleExportData = async () => {
    await exportGameData();
  };

  const handleImportData = async (event) => {
    const file = event.target.files[0];
    if (!file) return;
    
    try {
      await importGameData(file);
      alert('Data imported successfully!');
    } catch (error) {
      alert('Error importing data: ' + error.message);
    }
    
    // Reset the input
    event.target.value = '';
  };

  const renderPlayerSection = () => (
    <div className="space-y-4">
      <h3 className="font-semibold text-white mb-4">Player Statistics</h3>
      
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm text-gray-400 mb-1">Level</label>
          <input
            type="number"
            value={formData.player.level}
            onChange={(e) => handleInputChange('player', 'level', parseInt(e.target.value) || 1)}
            className="input-field w-full"
            min="1"
            max="100"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">Power</label>
          <input
            type="number"
            value={formData.player.power}
            onChange={(e) => handleInputChange('player', 'power', parseInt(e.target.value) || 0)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">Kills</label>
          <input
            type="number"
            value={formData.player.kills}
            onChange={(e) => handleInputChange('player', 'kills', parseInt(e.target.value) || 0)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">Deaths</label>
          <input
            type="number"
            value={formData.player.deaths}
            onChange={(e) => handleInputChange('player', 'deaths', parseInt(e.target.value) || 0)}
            className="input-field w-full"
            min="0"
          />
        </div>
      </div>
      
      <div>
        <label className="block text-sm text-gray-400 mb-1">Alliance</label>
        <input
          type="text"
          value={formData.player.alliance}
          onChange={(e) => handleInputChange('player', 'alliance', e.target.value)}
          className="input-field w-full"
          placeholder="Enter alliance name"
        />
      </div>
      
      <button onClick={handleSavePlayerStats} className="btn-primary w-full">
        Save Player Stats
      </button>
    </div>
  );

  const renderResourcesSection = () => (
    <div className="space-y-4">
      <h3 className="font-semibold text-white mb-4">Resources</h3>
      
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label className="block text-sm text-gray-400 mb-1">🥩 Meat</label>
          <input
            type="number"
            value={formData.resources.meat}
            onChange={(e) => handleResourceChange('meat', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">🪵 Wood</label>
          <input
            type="number"
            value={formData.resources.wood}
            onChange={(e) => handleResourceChange('wood', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">⚙️ Iron</label>
          <input
            type="number"
            value={formData.resources.iron}
            onChange={(e) => handleResourceChange('iron', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">⚫ Coal</label>
          <input
            type="number"
            value={formData.resources.coal}
            onChange={(e) => handleResourceChange('coal', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">🪨 Stone</label>
          <input
            type="number"
            value={formData.resources.stone}
            onChange={(e) => handleResourceChange('stone', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
        
        <div>
          <label className="block text-sm text-gray-400 mb-1">💎 Gems</label>
          <input
            type="number"
            value={formData.resources.gems}
            onChange={(e) => handleResourceChange('gems', e.target.value)}
            className="input-field w-full"
            min="0"
          />
        </div>
      </div>
      
      <div>
        <h4 className="font-semibold text-blue-400 mb-3">Speedups (minutes)</h4>
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm text-gray-400 mb-1">🏗️ Construction</label>
            <input
              type="number"
              value={formData.resources.speedups.construction}
              onChange={(e) => handleSpeedupChange('construction', e.target.value)}
              className="input-field w-full"
              min="0"
            />
          </div>
          
          <div>
            <label className="block text-sm text-gray-400 mb-1">🔬 Research</label>
            <input
              type="number"
              value={formData.resources.speedups.research}
              onChange={(e) => handleSpeedupChange('research', e.target.value)}
              className="input-field w-full"
              min="0"
            />
          </div>
          
          <div>
            <label className="block text-sm text-gray-400 mb-1">⚔️ Training</label>
            <input
              type="number"
              value={formData.resources.speedups.training}
              onChange={(e) => handleSpeedupChange('training', e.target.value)}
              className="input-field w-full"
              min="0"
            />
          </div>
          
          <div>
            <label className="block text-sm text-gray-400 mb-1">❤️ Healing</label>
            <input
              type="number"
              value={formData.resources.speedups.healing}
              onChange={(e) => handleSpeedupChange('healing', e.target.value)}
              className="input-field w-full"
              min="0"
            />
          </div>
        </div>
      </div>
      
      <button onClick={handleSaveResources} className="btn-primary w-full">
        Save Resources
      </button>
    </div>
  );

  const renderBuildingsSection = () => (
    <div className="space-y-4">
      <h3 className="font-semibold text-white mb-4">Building Levels</h3>
      
      <div className="space-y-3">
        {buildings.map(building => (
          <div key={building.id} className="card">
            <div className="flex items-center justify-between">
              <div>
                <h4 className="font-semibold text-white">{building.name}</h4>
                <p className="text-gray-400 text-sm">Max Level: {building.maxLevel}</p>
              </div>
              <div className="flex items-center space-x-2">
                <span className="text-gray-400 text-sm">Level:</span>
                <input
                  type="number"
                  value={building.level}
                  onChange={(e) => handleBuildingLevelChange(building.id, e.target.value)}
                  className="input-field w-20 text-center"
                  min="1"
                  max={building.maxLevel}
                />
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );

  const renderImportExportSection = () => (
    <div className="space-y-4">
      <h3 className="font-semibold text-white mb-4">Import/Export Data</h3>
      
      <div className="card">
        <h4 className="font-semibold text-blue-400 mb-2">Export Data</h4>
        <p className="text-gray-400 text-sm mb-3">
          Download your current game data as a JSON file for backup or sharing.
        </p>
        <button onClick={handleExportData} className="btn-primary w-full">
          📥 Export Data
        </button>
      </div>
      
      <div className="card">
        <h4 className="font-semibold text-blue-400 mb-2">Import Data</h4>
        <p className="text-gray-400 text-sm mb-3">
          Upload a previously exported JSON file to restore your game data.
        </p>
        <input
          type="file"
          accept=".json"
          onChange={handleImportData}
          className="input-field w-full"
        />
      </div>
      
      <div className="card border-red-600">
        <h4 className="font-semibold text-red-400 mb-2">Reset Data</h4>
        <p className="text-gray-400 text-sm mb-3">
          ⚠️ This will reset all your data to default values. This action cannot be undone.
        </p>
        <button 
          onClick={() => {
            if (confirm('Are you sure you want to reset all data? This cannot be undone.')) {
              resetGameState();
              setFormData({
                player: {
                  level: 1,
                  power: 1000,
                  kills: 0,
                  deaths: 0,
                  alliance: ''
                },
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
                }
              });
            }
          }}
          className="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded-lg transition-colors duration-200 w-full"
        >
          🗑️ Reset All Data
        </button>
      </div>
    </div>
  );

  const renderActiveSection = () => {
    switch (activeSection) {
      case 'player':
        return renderPlayerSection();
      case 'resources':
        return renderResourcesSection();
      case 'buildings':
        return renderBuildingsSection();
      case 'import':
        return renderImportExportSection();
      default:
        return renderPlayerSection();
    }
  };

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <section>
        <h2 className="text-lg font-semibold mb-2 text-blue-400">Data Input & Management</h2>
        <p className="text-gray-400 text-sm mb-4">
          Update your game data to get accurate calculations and recommendations
        </p>
      </section>

      {/* Database Status */}
      <DatabaseStatus />

      {/* Section Tabs */}
      <section>
        <div className="flex space-x-2 overflow-x-auto pb-2">
          {sections.map(section => (
            <button
              key={section.id}
              onClick={() => setActiveSection(section.id)}
              className={`flex items-center space-x-2 px-3 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors ${
                activeSection === section.id
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
              }`}
            >
              <span>{section.icon}</span>
              <span>{section.name}</span>
            </button>
          ))}
        </div>
      </section>

      {/* Active Section Content */}
      <section>
        {renderActiveSection()}
      </section>

      {/* Last Updated Info */}
      <div className="text-center text-gray-500 text-xs">
        Last updated: {player.lastUpdated.toLocaleString()}
      </div>
    </div>
  );
};

export default DataInput;
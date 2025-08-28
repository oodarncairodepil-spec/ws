import React, { useState } from 'react';
import { GameProvider } from './context/GameContext';
import Dashboard from './components/Dashboard';
import ResourceManager from './components/ResourceManager';
import BuildingManager from './components/BuildingManager';
import StrategyRecommendations from './components/StrategyRecommendations';
import DataInput from './components/DataInput';
import MobileNavigation from './components/MobileNavigation';

function App() {
  const [activeTab, setActiveTab] = useState('dashboard');

  const tabs = [
    { id: 'dashboard', name: 'Dashboard', icon: '🏠' },
    { id: 'resources', name: 'Resources', icon: '📦' },
    { id: 'buildings', name: 'Buildings', icon: '🏗️' },
    { id: 'strategy', name: 'Strategy', icon: '🎯' },
    { id: 'data', name: 'Data Input', icon: '📊' }
  ];

  const renderActiveComponent = () => {
    switch (activeTab) {
      case 'dashboard':
        return <Dashboard />;
      case 'resources':
        return <ResourceManager />;
      case 'buildings':
        return <BuildingManager />;
      case 'strategy':
        return <StrategyRecommendations />;
      case 'data':
        return <DataInput />;
      default:
        return <Dashboard />;
    }
  };

  return (
    <GameProvider>
      <div className="min-h-screen bg-gray-900 text-white flex flex-col sm:flex-row">
        {/* Desktop Sidebar Navigation */}
        <aside className="desktop-nav w-64 bg-gray-800 border-r border-gray-700 min-h-screen">
          <div className="p-4">
            <h1 className="text-lg font-bold text-blue-400 mb-6">❄️ Whiteout Survival</h1>
            <nav className="space-y-2">
              {tabs.map((tab) => (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`w-full flex items-center space-x-3 px-3 py-3 rounded-lg transition-colors text-left ${
                    activeTab === tab.id
                      ? 'bg-blue-600 text-white'
                      : 'text-gray-400 hover:text-white hover:bg-gray-700'
                  }`}
                >
                  <span className="text-lg">{tab.icon}</span>
                  <span className="font-medium">{tab.name}</span>
                </button>
              ))}
            </nav>
          </div>
        </aside>

        {/* Main Content Area */}
        <div className="flex-1 flex flex-col">
          {/* Mobile Header */}
          <header className="sm:hidden bg-gray-800 border-b border-gray-700 px-4 py-3">
            <div className="flex items-center justify-between">
              <h1 className="text-lg font-bold text-blue-400">❄️ Whiteout Survival</h1>
              <div className="text-xs text-gray-400">
                Strategy Tool
              </div>
            </div>
          </header>

          {/* Desktop Header */}
          <header className="hidden sm:block bg-gray-800 border-b border-gray-700 px-6 py-4">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-xl font-bold text-white">
                  {tabs.find(tab => tab.id === activeTab)?.icon} {tabs.find(tab => tab.id === activeTab)?.name}
                </h2>
                <p className="text-sm text-gray-400 mt-1">
                  Whiteout Survival Strategy & Analytics Tool
                </p>
              </div>
              <div className="text-sm text-gray-400">
                Mobile-Optimized Companion App
              </div>
            </div>
          </header>

          {/* Main Content */}
          <main className="flex-1 container-mobile pb-20 sm:pb-0">
            <div className="p-4 sm:p-6">
              {renderActiveComponent()}
            </div>
          </main>
        </div>

        {/* Mobile Bottom Navigation */}
        <MobileNavigation activeTab={activeTab} onTabChange={setActiveTab} />
      </div>
    </GameProvider>
  );
}

export default App

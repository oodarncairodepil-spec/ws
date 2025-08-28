import React from 'react';

const MobileNavigation = ({ activeTab, onTabChange }) => {
  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: '🏠' },
    { id: 'resources', label: 'Resources', icon: '📦' },
    { id: 'buildings', label: 'Buildings', icon: '🏗️' },
    { id: 'strategy', label: 'Strategy', icon: '🎯' },
    { id: 'data', label: 'Data', icon: '📊' }
  ];

  return (
    <nav className="mobile-nav">
      <div className="grid grid-cols-5 gap-1">
        {navItems.map((item) => (
          <button
            key={item.id}
            onClick={() => onTabChange(item.id)}
            className={`mobile-nav-item ${
              activeTab === item.id ? 'active' : ''
            }`}
          >
            <span className="text-lg mb-1">{item.icon}</span>
            <span className="text-xs">{item.label}</span>
          </button>
        ))}
      </div>
    </nav>
  );
};

export default MobileNavigation;
import React from 'react';
import { Button } from '@/components/ui/button';

const MobileNavigation = ({ activeTab, onTabChange }) => {
  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: '🏠' },
    { id: 'resources', label: 'Resources', icon: '📦' },
    { id: 'buildings', label: 'Buildings', icon: '🏗️' },
    { id: 'strategy', label: 'Strategy', icon: '🎯' },
    { id: 'data', label: 'Data', icon: '📊' }
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-background border-t border-border z-50 safe-area-pb">
      <div className="grid grid-cols-5 gap-1 p-2">
        {navItems.map((item) => (
          <Button
            key={item.id}
            variant={activeTab === item.id ? 'default' : 'ghost'}
            size="sm"
            onClick={() => onTabChange(item.id)}
            className="flex flex-col items-center justify-center h-16 min-h-[4rem] px-1 py-2 text-xs gap-1"
          >
            <span className="text-lg leading-none">{item.icon}</span>
            <span className="text-[10px] leading-tight text-center">{item.label}</span>
          </Button>
        ))}
      </div>
    </nav>
  );
};

export default MobileNavigation;
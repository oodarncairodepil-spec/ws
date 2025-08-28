import React from 'react';
import { useGame } from '../context/GameContext';
import { formatNumber, formatTime, calculateResourceProduction, generateOptimizationRecommendations } from '../utils/gameCalculations';

const Dashboard = () => {
  const { gameState } = useGame();
  const { player, buildings, research } = gameState;
  const production = calculateResourceProduction(buildings);
  const recommendations = generateOptimizationRecommendations(player, buildings, research);

  const StatCard = ({ title, value, subtitle, icon, color = 'blue' }) => (
    <div className="card p-mobile">
      <div className="flex items-center justify-between">
        <div className="flex-1">
          <p className="text-gray-400 text-mobile-sm">{title}</p>
          <p className={`text-mobile-lg font-bold text-${color}-400`}>{value}</p>
          {subtitle && <p className="text-gray-500 text-xs">{subtitle}</p>}
        </div>
        <div className={`text-2xl sm:text-3xl text-${color}-400`}>{icon}</div>
      </div>
    </div>
  );

  const ResourceCard = ({ name, current, production, icon }) => (
    <div className="bg-gray-800 rounded-lg p-mobile border border-gray-700">
      <div className="flex items-center justify-between mb-2">
        <span className="text-gray-400 text-mobile-sm">{name}</span>
        <span className="text-lg">{icon}</span>
      </div>
      <div className="text-white font-semibold text-mobile-base">{formatNumber(current)}</div>
      <div className="text-green-400 text-xs">+{formatNumber(production)}/hr</div>
    </div>
  );

  return (
    <div className="space-y-6">
      {/* Player Overview */}
      <section>
        <h2 className="text-mobile-lg font-semibold mb-4 text-blue-400">Player Overview</h2>
        <div className="grid-responsive-2 gap-3 sm:gap-4">
          <StatCard
            title="Power"
            value={formatNumber(player.power)}
            icon="⚡"
            color="yellow"
          />
          <StatCard
            title="Level"
            value={player.level}
            icon="🏆"
            color="purple"
          />
          <StatCard
            title="Kills"
            value={formatNumber(player.kills)}
            icon="⚔️"
            color="red"
          />
          <StatCard
            title="Buildings"
            value={buildings.length}
            subtitle={`Avg Level: ${Math.round(buildings.reduce((sum, b) => sum + b.level, 0) / buildings.length)}`}
            icon="🏗️"
            color="green"
          />
        </div>
      </section>

      {/* Resources Overview */}
      <section>
        <h2 className="text-mobile-lg font-semibold mb-4 text-blue-400">Resources</h2>
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
          <ResourceCard
            name="Meat"
            current={player.resources.meat}
            production={production.meat}
            icon="🥩"
          />
          <ResourceCard
            name="Wood"
            current={player.resources.wood}
            production={production.wood}
            icon="🪵"
          />
          <ResourceCard
            name="Iron"
            current={player.resources.iron}
            production={production.iron}
            icon="⚙️"
          />
          <ResourceCard
            name="Coal"
            current={player.resources.coal}
            production={production.coal}
            icon="⚫"
          />
          <ResourceCard
            name="Stone"
            current={player.resources.stone}
            production={production.stone}
            icon="🪨"
          />
          <ResourceCard
            name="Gems"
            current={player.resources.gems}
            production={0}
            icon="💎"
          />
        </div>
      </section>

      {/* Quick Actions */}
      <section>
        <h2 className="text-mobile-lg font-semibold mb-4 text-blue-400">Quick Actions</h2>
        <div className="grid-responsive-2 gap-3">
          <button className="btn-primary space-x-2">
            <span>📊</span>
            <span className="text-mobile-sm">Calculate Upgrades</span>
          </button>
          <button className="btn-secondary space-x-2">
            <span>🎯</span>
            <span className="text-mobile-sm">View Strategy</span>
          </button>
          <button className="btn-secondary space-x-2">
            <span>⚙️</span>
            <span className="text-mobile-sm">Update Data</span>
          </button>
          <button className="btn-secondary space-x-2">
            <span>📈</span>
            <span className="text-mobile-sm">Progress Report</span>
          </button>
        </div>
      </section>

      {/* Top Recommendations */}
      <section>
        <h2 className="text-mobile-lg font-semibold mb-4 text-blue-400">Top Recommendations</h2>
        <div className="space-y-3">
          {recommendations.slice(0, 3).map((rec) => (
            <div key={rec.id} className="card p-mobile">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center space-x-2 mb-1">
                    <span className={`w-2 h-2 rounded-full ${
                      rec.priority >= 8 ? 'bg-red-400' :
                      rec.priority >= 6 ? 'bg-yellow-400' : 'bg-green-400'
                    }`}></span>
                    <h3 className="font-semibold text-white text-mobile-base">{rec.title}</h3>
                  </div>
                  <p className="text-gray-400 text-mobile-sm mb-2">{rec.description}</p>
                  <div className="flex items-center space-x-4 text-xs text-gray-500">
                    <span>⏱️ {formatTime(rec.timeToComplete)}</span>
                    <span>📈 {rec.estimatedBenefit}</span>
                  </div>
                </div>
                <button className="btn-primary text-xs px-3 py-2 ml-3 touch-target">
                  View
                </button>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Last Updated */}
      <div className="text-center text-gray-500 text-xs">
        Last updated: {player.lastUpdated.toLocaleTimeString()}
      </div>
    </div>
  );
};

export default Dashboard;
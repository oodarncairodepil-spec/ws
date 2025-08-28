import React from 'react';
import { useGame } from '../context/GameContext';
import { formatNumber, formatTime, calculateResourceProduction, generateOptimizationRecommendations } from '../utils/gameCalculations';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';

const Dashboard = () => {
  const { gameState } = useGame();
  const { player, buildings, research } = gameState;
  const production = calculateResourceProduction(buildings);
  const recommendations = generateOptimizationRecommendations(player, buildings, research);

  const StatCard = ({ title, value, subtitle, icon, color = 'blue' }) => (
    <Card className="p-3 sm:p-4">
      <CardContent className="p-0">
        <div className="flex items-center justify-between">
          <div className="flex-1">
            <p className="text-muted-foreground text-sm">{title}</p>
            <p className={`text-lg sm:text-xl font-bold text-${color}-400`}>{value}</p>
            {subtitle && <p className="text-muted-foreground text-xs">{subtitle}</p>}
          </div>
          <div className={`text-2xl sm:text-3xl text-${color}-400`}>{icon}</div>
        </div>
      </CardContent>
    </Card>
  );

  const ResourceCard = ({ name, current, production, icon }) => (
    <Card className="p-3">
      <CardContent className="p-0">
        <div className="flex items-center justify-between mb-2">
          <span className="text-muted-foreground text-sm">{name}</span>
          <span className="text-lg">{icon}</span>
        </div>
        <div className="font-semibold text-base">{formatNumber(current)}</div>
        <div className="text-green-400 text-xs">+{formatNumber(production)}/hr</div>
      </CardContent>
    </Card>
  );

  return (
    <div className="space-y-6">
      {/* Player Overview */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Player Overview</h2>
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
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Resources</h2>
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
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Quick Actions</h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          <Button className="h-12 justify-start space-x-2" variant="default">
            <span>📊</span>
            <span>Calculate Upgrades</span>
          </Button>
          <Button className="h-12 justify-start space-x-2" variant="outline">
            <span>🎯</span>
            <span>View Strategy</span>
          </Button>
          <Button className="h-12 justify-start space-x-2" variant="outline">
            <span>⚙️</span>
            <span>Update Data</span>
          </Button>
          <Button className="h-12 justify-start space-x-2" variant="outline">
            <span>📈</span>
            <span>Progress Report</span>
          </Button>
        </div>
      </section>

      {/* Top Recommendations */}
      <section>
        <h2 className="text-lg font-semibold mb-4 text-blue-400">Top Recommendations</h2>
        <div className="space-y-3">
          {recommendations.slice(0, 3).map((rec) => (
            <Card key={rec.id} className="p-4">
              <CardContent className="p-0">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center space-x-2 mb-1">
                      <span className={`w-2 h-2 rounded-full ${
                        rec.priority >= 8 ? 'bg-red-400' :
                        rec.priority >= 6 ? 'bg-yellow-400' : 'bg-green-400'
                      }`}></span>
                      <h3 className="font-semibold text-base">{rec.title}</h3>
                    </div>
                    <p className="text-muted-foreground text-sm mb-2">{rec.description}</p>
                    <div className="flex items-center space-x-4 text-xs text-muted-foreground">
                      <span>⏱️ {formatTime(rec.timeToComplete)}</span>
                      <span>📈 {rec.estimatedBenefit}</span>
                    </div>
                  </div>
                  <Button size="sm" className="ml-3">
                    View
                  </Button>
                </div>
              </CardContent>
            </Card>
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
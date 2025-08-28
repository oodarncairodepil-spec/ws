import React, { useState, useEffect } from 'react';
import { useGame } from '../context/GameContext';
import { useDatabase } from '../hooks/useDatabase';
import { generateOptimizationRecommendations, calculateOptimalUpgradeSequence, formatTime, formatNumber } from '../utils/gameCalculations';

const StrategyRecommendations = () => {
  const { gameState, addGoal } = useGame();
  const { player, buildings, research } = gameState;
  const { saveStrategy, loadStrategies } = useDatabase();
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [expandedRec, setExpandedRec] = useState(null);
  const [showOptimalSequence, setShowOptimalSequence] = useState(false);
  const [savedStrategies, setSavedStrategies] = useState([]);
  const [optimalSequence, setOptimalSequence] = useState([]);

  const recommendations = generateOptimizationRecommendations(player, buildings, research);

  // Load saved strategies on component mount
  useEffect(() => {
    const loadSavedStrategies = async () => {
      try {
        const strategies = await loadStrategies();
        setSavedStrategies(strategies || []);
      } catch (error) {
        console.error('Failed to load strategies:', error);
      }
    };
    loadSavedStrategies();
  }, [loadStrategies]);

  // Calculate optimal upgrade sequence
  useEffect(() => {
    const sequence = calculateOptimalUpgradeSequence(player, buildings);
    setOptimalSequence(sequence);
  }, [player, buildings]);

  const categories = [
    { id: 'all', name: 'All', icon: '📋' },
    { id: 'building', name: 'Buildings', icon: '🏗️' },
    { id: 'research', name: 'Research', icon: '🔬' },
    { id: 'resource', name: 'Resources', icon: '📦' },
    { id: 'combat', name: 'Combat', icon: '⚔️' },
    { id: 'hero', name: 'Heroes', icon: '🦸' }
  ];

  const filteredRecommendations = selectedCategory === 'all' 
    ? recommendations 
    : recommendations.filter(rec => rec.category === selectedCategory);

  const getPriorityColor = (priority) => {
    if (priority >= 8) return 'bg-red-500';
    if (priority >= 6) return 'bg-yellow-500';
    if (priority >= 4) return 'bg-blue-500';
    return 'bg-green-500';
  };

  const getPriorityText = (priority) => {
    if (priority >= 8) return 'Critical';
    if (priority >= 6) return 'High';
    if (priority >= 4) return 'Medium';
    return 'Low';
  };

  const RecommendationCard = ({ recommendation }) => {
    const isExpanded = expandedRec === recommendation.id;
    
    return (
      <div className="card">
        <div className="flex items-start justify-between mb-3">
          <div className="flex-1">
            <div className="flex items-center space-x-2 mb-2">
              <div className={`w-3 h-3 rounded-full ${getPriorityColor(recommendation.priority)}`}></div>
              <span className={`text-xs px-2 py-1 rounded ${getPriorityColor(recommendation.priority)} text-white`}>
                {getPriorityText(recommendation.priority)}
              </span>
              <span className="text-xs bg-gray-700 text-gray-300 px-2 py-1 rounded capitalize">
                {recommendation.category}
              </span>
            </div>
            <h3 className="font-semibold text-white mb-1">{recommendation.title}</h3>
            <p className="text-gray-400 text-sm mb-3">{recommendation.description}</p>
            
            <div className="flex items-center space-x-4 text-xs text-gray-500 mb-3">
              <span className="flex items-center space-x-1">
                <span>⏱️</span>
                <span>{formatTime(recommendation.timeToComplete)}</span>
              </span>
              <span className="flex items-center space-x-1">
                <span>📈</span>
                <span>{recommendation.estimatedBenefit}</span>
              </span>
            </div>
          </div>
          
          <button
            onClick={() => setExpandedRec(isExpanded ? null : recommendation.id)}
            className="btn-secondary text-xs px-3 py-1 ml-3"
          >
            {isExpanded ? 'Less' : 'More'}
          </button>
        </div>

        {isExpanded && (
          <div className="border-t border-gray-700 pt-3 space-y-4">
            {/* Required Resources */}
            <div>
              <h4 className="font-semibold text-blue-400 mb-2">Required Resources</h4>
              <div className="grid grid-cols-3 gap-2">
                {Object.entries(recommendation.requiredResources).map(([resource, amount]) => {
                  if (resource === 'speedups' || amount === 0) return null;
                  const current = player.resources[resource];
                  const hasEnough = current >= amount;
                  
                  return (
                    <div key={resource} className="bg-gray-700 rounded p-2 text-center">
                      <div className={`text-sm font-semibold ${hasEnough ? 'text-green-400' : 'text-red-400'}`}>
                        {formatNumber(amount)}
                      </div>
                      <div className="text-xs text-gray-400 capitalize">{resource}</div>
                      <div className="text-xs text-gray-500">
                        ({formatNumber(current)} available)
                      </div>
                    </div>
                  );
                }).filter(Boolean)}
              </div>
            </div>

            {/* Steps */}
            <div>
              <h4 className="font-semibold text-blue-400 mb-2">Action Steps</h4>
              <div className="space-y-2">
                {recommendation.steps.map((step, index) => (
                  <div key={index} className="flex items-start space-x-3">
                    <div className="bg-blue-600 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center mt-0.5">
                      {index + 1}
                    </div>
                    <p className="text-gray-300 text-sm flex-1">{step}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Action Buttons */}
            <div className="flex space-x-3">
              <button
                onClick={() => handleAddToGoals(recommendation)}
                className="btn-primary flex-1"
              >
                Add to Goals
              </button>
              <button
                onClick={() => saveRecommendation(recommendation)}
                className="btn-secondary flex-1"
              >
                Save Strategy
              </button>
              <button
                onClick={() => handleMarkAsCompleted(recommendation.id)}
                className="btn-secondary flex-1"
              >
                Mark Done
              </button>
            </div>
          </div>
        )}
      </div>
    );
  };

  const handleAddToGoals = (recommendation) => {
    const goal = {
      id: `goal-${Date.now()}`,
      title: recommendation.title,
      description: recommendation.description,
      priority: recommendation.priority >= 8 ? 'critical' : 
                recommendation.priority >= 6 ? 'high' : 
                recommendation.priority >= 4 ? 'medium' : 'low',
      estimatedTime: recommendation.timeToComplete,
      requiredResources: recommendation.requiredResources,
      completed: false,
      category: recommendation.category
    };
    addGoal(goal);
  };

  const saveRecommendation = async (recommendation) => {
    try {
      const strategy = {
        title: recommendation.title,
        description: recommendation.description,
        category: recommendation.category,
        priority: recommendation.priority,
        requirements: recommendation.requiredResources,
        steps: recommendation.steps
      };
      
      const success = await saveStrategy(strategy);
      if (success) {
        // Reload strategies to show the new one
        const strategies = await loadStrategies();
        setSavedStrategies(strategies);
      }
    } catch (error) {
      console.error('Failed to save strategy:', error);
    }
  };

  const handleMarkAsCompleted = (recId) => {
    // This would typically remove the recommendation or mark it as completed
    console.log('Marking recommendation as completed:', recId);
  };

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <section>
        <h2 className="text-lg font-semibold mb-2 text-blue-400">Strategy Recommendations</h2>
        <p className="text-gray-400 text-sm mb-4">
          AI-generated strategic advice based on your current game state
        </p>
      </section>

      {/* Strategy Tabs */}
      <section>
        <div className="flex space-x-2 mb-4">
          <button
            onClick={() => setShowOptimalSequence(false)}
            className={`px-4 py-2 rounded-lg font-medium transition-colors ${
              !showOptimalSequence
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            📋 Recommendations
          </button>
          <button
            onClick={() => setShowOptimalSequence(true)}
            className={`px-4 py-2 rounded-lg font-medium transition-colors ${
              showOptimalSequence
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            🎯 Optimal Sequence
          </button>
        </div>
      </section>

      {showOptimalSequence ? (
        /* Optimal Upgrade Sequence */
        <section>
          <div className="card">
            <h3 className="text-lg font-semibold text-white mb-3">🎯 Optimal Upgrade Sequence</h3>
            <p className="text-gray-400 mb-4">
              Based on your current resources, here's the most efficient upgrade order:
            </p>
            
            {optimalSequence.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-400">No affordable upgrades available with current resources.</p>
              </div>
            ) : (
              <div className="space-y-3">
                {optimalSequence.map((upgrade, index) => (
                  <div key={index} className="bg-gray-700 rounded-lg p-4">
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center space-x-3">
                        <span className="bg-blue-600 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold">
                          {index + 1}
                        </span>
                        <h4 className="text-white font-medium">
                          Upgrade {upgrade.building.name} to Level {upgrade.building.level}
                        </h4>
                      </div>
                      <span className="text-green-400 font-medium">
                        +{formatNumber(upgrade.powerGain)} Power
                      </span>
                    </div>
                    
                    <div className="text-sm text-gray-300">
                      <span className="text-gray-400">Cost: </span>
                      {Object.entries(upgrade.cost)
                        .filter(([resource, amount]) => resource !== 'speedups' && amount > 0)
                        .map(([resource, amount]) => `${formatNumber(amount)} ${resource}`)
                        .join(', ')}
                    </div>
                    
                    <div className="text-sm text-gray-400 mt-1">
                      Efficiency Score: {upgrade.score.toFixed(2)}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </section>
      ) : (
        <>
          {/* Category Filter */}
          <section>
            <div className="flex space-x-2 overflow-x-auto pb-2">
              {categories.map(category => (
                <button
                  key={category.id}
                  onClick={() => setSelectedCategory(category.id)}
                  className={`flex items-center space-x-2 px-3 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors ${
                    selectedCategory === category.id
                      ? 'bg-blue-600 text-white'
                      : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                  }`}
                >
                  <span>{category.icon}</span>
                  <span>{category.name}</span>
                </button>
              ))}
            </div>
          </section>

      {/* Summary Stats */}
      <section>
        <div className="grid grid-cols-4 gap-3">
          <div className="card text-center">
            <div className="text-lg font-bold text-red-400">
              {recommendations.filter(r => r.priority >= 8).length}
            </div>
            <div className="text-gray-400 text-xs">Critical</div>
          </div>
          <div className="card text-center">
            <div className="text-lg font-bold text-yellow-400">
              {recommendations.filter(r => r.priority >= 6 && r.priority < 8).length}
            </div>
            <div className="text-gray-400 text-xs">High</div>
          </div>
          <div className="card text-center">
            <div className="text-lg font-bold text-blue-400">
              {recommendations.filter(r => r.priority >= 4 && r.priority < 6).length}
            </div>
            <div className="text-gray-400 text-xs">Medium</div>
          </div>
          <div className="card text-center">
            <div className="text-lg font-bold text-green-400">
              {recommendations.filter(r => r.priority < 4).length}
            </div>
            <div className="text-gray-400 text-xs">Low</div>
          </div>
        </div>
      </section>

      {/* Recommendations List */}
      <section>
        <div className="flex justify-between items-center mb-4">
          <h3 className="font-semibold text-white">
            {selectedCategory === 'all' ? 'All Recommendations' : `${categories.find(c => c.id === selectedCategory)?.name} Recommendations`}
          </h3>
          <span className="text-gray-400 text-sm">
            {filteredRecommendations.length} items
          </span>
        </div>

        {filteredRecommendations.length > 0 ? (
          <div className="space-y-4">
            {filteredRecommendations.map(recommendation => (
              <RecommendationCard key={recommendation.id} recommendation={recommendation} />
            ))}
          </div>
        ) : (
          <div className="card text-center py-8">
            <div className="text-4xl mb-2">🎉</div>
            <h3 className="font-semibold text-white mb-1">No Recommendations</h3>
            <p className="text-gray-400 text-sm">
              {selectedCategory === 'all' 
                ? 'Great job! You\'re doing well in all areas.'
                : `No ${categories.find(c => c.id === selectedCategory)?.name.toLowerCase()} recommendations at this time.`
              }
            </p>
          </div>
        )}
      </section>

      {/* Quick Actions */}
      <section>
        <h3 className="font-semibold text-white mb-4">Quick Actions</h3>
        <div className="grid grid-cols-2 gap-3">
          <button className="btn-primary flex items-center justify-center space-x-2">
            <span>🔄</span>
            <span>Refresh Analysis</span>
          </button>
          <button className="btn-secondary flex items-center justify-center space-x-2">
            <span>📊</span>
            <span>View Analytics</span>
          </button>
          <button className="btn-secondary flex items-center justify-center space-x-2">
            <span>🎯</span>
            <span>Set Goals</span>
          </button>
          <button className="btn-secondary flex items-center justify-center space-x-2">
            <span>📈</span>
            <span>Progress Report</span>
          </button>
        </div>
          </section>
          
          {/* Saved Strategies */}
          {savedStrategies.length > 0 && (
            <section>
              <h3 className="font-semibold text-white mb-4">💾 Saved Strategies</h3>
              <div className="space-y-3">
                {savedStrategies.slice(0, 5).map((strategy) => (
                  <div key={strategy.id} className="card">
                    <div className="flex items-center justify-between mb-2">
                      <h4 className="text-white font-medium">{strategy.title}</h4>
                      <span className={`px-2 py-1 rounded text-xs font-medium ${
                        strategy.priority > 70 ? 'bg-red-900 text-red-200' :
                        strategy.priority > 50 ? 'bg-yellow-900 text-yellow-200' :
                        'bg-green-900 text-green-200'
                      }`}>
                        {strategy.priority > 70 ? 'High' : strategy.priority > 50 ? 'Medium' : 'Low'} Priority
                      </span>
                    </div>
                    <p className="text-gray-400 text-sm mb-2">{strategy.description}</p>
                    <div className="text-xs text-gray-500">
                      Saved: {new Date(strategy.created_at).toLocaleDateString()}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}
        </>
      )}
    </div>
  );
};

export default StrategyRecommendations;
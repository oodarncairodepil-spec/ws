import React, { useState } from 'react';
import { useDatabase } from '../hooks/useDatabase';
import { testDatabaseConnection, runAllDatabaseTests } from '../utils/testDatabase';

const DatabaseStatus = () => {
  const {
    isConnected,
    isLoading,
    lastSaved,
    autoSave,
    setAutoSave,
    saveGameState,
    loadGameState,
    exportGameData,
    getConnectionInfo
  } = useDatabase();

  const [showDetails, setShowDetails] = useState(false);
  const [actionStatus, setActionStatus] = useState('');
  const [testResults, setTestResults] = useState(null);

  const handleSave = async () => {
    setActionStatus('Saving...');
    const success = await saveGameState();
    setActionStatus(success ? 'Saved successfully!' : 'Save failed');
    setTimeout(() => setActionStatus(''), 3000);
  };

  const handleLoad = async () => {
    setActionStatus('Loading...');
    const success = await loadGameState();
    setActionStatus(success ? 'Loaded successfully!' : 'Load failed');
    setTimeout(() => setActionStatus(''), 3000);
  };

  const handleExport = async () => {
    setActionStatus('Exporting...');
    const success = await exportGameData();
    setActionStatus(success ? 'Exported successfully!' : 'Export failed');
    setTimeout(() => setActionStatus(''), 3000);
  };

  const handleTestConnection = async () => {
    setActionStatus('Testing connection...');
    const result = await testDatabaseConnection();
    setTestResults(result);
    setActionStatus(result.success ? 'Connection test passed!' : 'Connection test failed!');
    setTimeout(() => setActionStatus(''), 3000);
  };

  const handleRunAllTests = async () => {
    setActionStatus('Running all tests...');
    const results = await runAllDatabaseTests();
    setTestResults(results);
    setActionStatus(results.success ? 'All tests passed!' : 'Some tests failed!');
    setTimeout(() => setActionStatus(''), 5000);
  };

  const connectionInfo = getConnectionInfo();

  return (
    <div className="bg-gray-800 rounded-lg p-4 mb-4">
      {/* Status Header */}
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center space-x-3">
          <div className={`w-3 h-3 rounded-full ${
            isConnected ? 'bg-green-500' : 'bg-red-500'
          }`} />
          <div>
            <h3 className="text-lg font-semibold text-white">
              Database Status
            </h3>
            <p className="text-sm text-gray-400">
              {connectionInfo.status}
            </p>
          </div>
        </div>
        
        <button
          onClick={() => setShowDetails(!showDetails)}
          className="text-blue-400 hover:text-blue-300 transition-colors"
        >
          {showDetails ? '▼' : '▶'} Details
        </button>
      </div>

      {/* Action Status */}
      {actionStatus && (
        <div className="mb-3 p-2 bg-blue-900/50 rounded text-blue-200 text-sm">
          {actionStatus}
        </div>
      )}

      {/* Quick Actions */}
      <div className="flex flex-wrap gap-2 mb-3">
        <button
          onClick={handleSave}
          disabled={!isConnected || isLoading}
          className="px-3 py-1 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-600 disabled:cursor-not-allowed rounded text-sm font-medium transition-colors"
        >
          {isLoading ? '⏳' : '💾'} Save
        </button>
        
        <button
          onClick={handleLoad}
          disabled={!isConnected || isLoading}
          className="px-3 py-1 bg-green-600 hover:bg-green-700 disabled:bg-gray-600 disabled:cursor-not-allowed rounded text-sm font-medium transition-colors"
        >
          {isLoading ? '⏳' : '📥'} Load
        </button>
        
        <button
          onClick={handleExport}
          disabled={isLoading}
          className="px-3 py-1 bg-purple-600 hover:bg-purple-700 disabled:bg-gray-600 disabled:cursor-not-allowed rounded text-sm font-medium transition-colors"
        >
          {isLoading ? '⏳' : '📤'} Export
        </button>
        
        <button
          onClick={handleTestConnection}
          disabled={isLoading}
          className="px-3 py-1 bg-orange-600 hover:bg-orange-700 disabled:bg-gray-600 disabled:cursor-not-allowed rounded text-sm font-medium transition-colors"
        >
          {isLoading ? '⏳' : '🔧'} Test
        </button>
      </div>

      {/* Auto-save Toggle */}
      <div className="flex items-center justify-between mb-3">
        <span className="text-sm text-gray-300">Auto-save (30s)</span>
        <button
          onClick={() => setAutoSave(!autoSave)}
          className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
            autoSave ? 'bg-blue-600' : 'bg-gray-600'
          }`}
        >
          <span
            className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
              autoSave ? 'translate-x-6' : 'translate-x-1'
            }`}
          />
        </button>
      </div>

      {/* Detailed Information */}
      {showDetails && (
        <div className="border-t border-gray-700 pt-3 space-y-2">
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <span className="text-gray-400">Connection:</span>
              <span className={`ml-2 font-medium ${
                isConnected ? 'text-green-400' : 'text-red-400'
              }`}>
                {isConnected ? 'Online' : 'Offline'}
              </span>
            </div>
            
            <div>
              <span className="text-gray-400">Auto-save:</span>
              <span className={`ml-2 font-medium ${
                autoSave ? 'text-green-400' : 'text-gray-400'
              }`}>
                {autoSave ? 'Enabled' : 'Disabled'}
              </span>
            </div>
            
            <div className="col-span-2">
              <span className="text-gray-400">Last saved:</span>
              <span className="ml-2 text-white">
                {lastSaved ? new Date(lastSaved).toLocaleString() : 'Never'}
              </span>
            </div>
          </div>
          
          {!isConnected && (
            <div className="mt-3 p-3 bg-yellow-900/50 rounded border border-yellow-700">
              <h4 className="text-yellow-400 font-medium mb-1">Offline Mode</h4>
              <p className="text-yellow-200 text-sm">
                Your data is stored locally. Connect to the internet to sync with the cloud database.
              </p>
            </div>
          )}
          
          {isConnected && (
            <div className="mt-3 p-3 bg-green-900/50 rounded border border-green-700">
              <h4 className="text-green-400 font-medium mb-1">Cloud Sync Active</h4>
              <p className="text-green-200 text-sm">
                Your game data is automatically synced with Supabase every 30 seconds when auto-save is enabled.
              </p>
            </div>
          )}
          
          {/* Test Results */}
          {testResults && (
            <div className="mt-3 p-3 rounded border">
              <div className={`${testResults.success ? 'bg-green-900/50 border-green-700' : 'bg-red-900/50 border-red-700'}`}>
                <h4 className={`font-medium mb-2 ${testResults.success ? 'text-green-400' : 'text-red-400'}`}>
                  {testResults.success ? '✅ Tests Passed' : '❌ Tests Failed'}
                </h4>
                <p className={`text-sm mb-2 ${testResults.success ? 'text-green-200' : 'text-red-200'}`}>
                  {testResults.summary || testResults.message}
                </p>
                
                {testResults.results && (
                  <div className="space-y-1 text-xs">
                    {Object.entries(testResults.results).map(([testName, result]) => (
                      <div key={testName} className="flex items-center space-x-2">
                        <span className={result.success ? 'text-green-400' : 'text-red-400'}>
                          {result.success ? '✅' : '❌'}
                        </span>
                        <span className="capitalize text-gray-300">{testName} Test</span>
                        {!result.success && result.error && (
                          <span className="text-red-300">- {result.error}</span>
                        )}
                      </div>
                    ))}
                  </div>
                )}
                
                {testResults.error && (
                  <div className="mt-2 text-xs text-red-300">
                    Error: {testResults.error}
                  </div>
                )}
              </div>
              
              <button
                onClick={handleRunAllTests}
                disabled={isLoading}
                className="mt-2 px-2 py-1 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-600 disabled:cursor-not-allowed rounded text-xs font-medium transition-colors"
              >
                Run Full Test Suite
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default DatabaseStatus;
-- Migration: Add Fire Crystal Furnace building data
-- This script adds Fire Crystal Furnace levels to the building_levels table
-- Run this after the initial setup.sql has been executed

-- Add Fire Crystal resources if not exists
INSERT INTO resources (name, type, description) VALUES
('Fire Crystals', 'premium', 'Special crystals used for advanced building upgrades'),
('Refined Fire Crystals', 'premium', 'Processed fire crystals for high-tier construction')
ON CONFLICT (name) DO NOTHING;

-- Add Fire Crystal Furnace building if not exists
INSERT INTO buildings (name, type, base_cost, base_power, max_level, description) VALUES
('Fire Crystal Furnace', 'advanced', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132}', 1580900, 35, 'Advanced furnace powered by fire crystals for maximum efficiency')
ON CONFLICT DO NOTHING;

-- Add Fire Crystal Furnace building levels
-- Note: Fire Crystal levels use special naming convention (30-1, 30-2, etc.)
-- We'll store them as levels 31-35 for database consistency
INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) VALUES
('Fire Crystal Furnace', 31, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1580900),
('Fire Crystal Furnace', 32, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1638300),
('Fire Crystal Furnace', 33, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1695700),
('Fire Crystal Furnace', 34, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1753100),
('Fire Crystal Furnace', 35, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1810500)
ON CONFLICT (building_name, level) DO NOTHING;

-- Create RLS policy for Fire Crystal Furnace if not exists
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'building_levels' 
        AND policyname = 'Public read access to building levels'
    ) THEN
        CREATE POLICY "Public read access to building levels" ON building_levels
        FOR SELECT USING (true);
    END IF;
END $$;

-- Add comment for tracking
COMMENT ON TABLE building_levels IS 'Building levels data including Fire Crystal Furnace - Updated with migration 001';
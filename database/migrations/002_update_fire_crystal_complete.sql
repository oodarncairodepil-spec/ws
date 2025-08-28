-- Migration: Complete Fire Crystal data update
-- This script adds all Fire Crystal buildings and levels with correct naming from CSV
-- Based on KingShot x Whiteout - WS Building FC.csv

-- First, remove existing Fire Crystal data to avoid conflicts
DELETE FROM building_levels WHERE building_name LIKE '%Fire Crystal%' OR building_name LIKE 'FC-%';
DELETE FROM buildings WHERE name LIKE '%Fire Crystal%' OR name LIKE 'FC-%';

-- Add Fire Crystal resources if not exists
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM resources WHERE name = 'Fire Crystals') THEN
        INSERT INTO resources (name, type, description) VALUES
        ('Fire Crystals', 'premium', 'Special crystals used for advanced building upgrades');
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM resources WHERE name = 'Refined Fire Crystals') THEN
        INSERT INTO resources (name, type, description) VALUES
        ('Refined Fire Crystals', 'premium', 'Processed fire crystals for high-tier construction');
    END IF;
END $$;

-- Add Fire Crystal buildings
DO $$
BEGIN
    -- Fire Crystal Furnace
    IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'Fire Crystal Furnace') THEN
        INSERT INTO buildings (name, type, base_cost, base_power, max_level, description) VALUES
        ('Fire Crystal Furnace', 'advanced', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132}', 1580900, 50, 'Advanced furnace powered by fire crystals for maximum efficiency');
    ELSE
        UPDATE buildings SET max_level = 50 WHERE name = 'Fire Crystal Furnace';
    END IF;
    
    -- Fire Crystal Embassy
    IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'FC-Embassy') THEN
        INSERT INTO buildings (name, type, base_cost, base_power, max_level, description) VALUES
        ('FC-Embassy', 'advanced', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 679000, "FireCrystals": 33}', 347798, 50, 'Fire Crystal enhanced Embassy for advanced diplomacy');
    ELSE
        UPDATE buildings SET max_level = 50 WHERE name = 'FC-Embassy';
    END IF;
    
    -- Fire Crystal Embassy Levels
    -- Levels 1-5 (30-1 through FC 1)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 1) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 1, 'Furnace FC-1', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 679000, "FireCrystals": 33, "RefinedFireCrystals": 0}', '4d 14:52:00', 347798);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 2) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 2, 'Furnace FC-1', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 670000, "FireCrystals": 33, "RefinedFireCrystals": 0}', '4d 14:52:00', 360426);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 3) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 3, 'Furnace FC-1', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 670000, "FireCrystals": 33, "RefinedFireCrystals": 0}', '4d 14:52:00', 373054);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 4) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 4, 'Furnace FC-1', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 670000, "FireCrystals": 33, "RefinedFireCrystals": 0}', '4d 14:52:00', 385682);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 5) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 5, 'Furnace FC-1', '{"Meat": 13000000, "Wood": 13000000, "Coal": 2700000, "Iron": 670000, "FireCrystals": 33, "RefinedFireCrystals": 0}', '4d 14:52:00', 398310);
    END IF;
    
    -- Levels 6-10 (FC1-1 through FC 2)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 6) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 6, 'Furnace FC-2', '{"Meat": 14000000, "Wood": 14000000, "Coal": 2900000, "Iron": 720000, "FireCrystals": 39, "RefinedFireCrystals": 0}', '5d 22:33:00', 410938);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 7) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 7, 'Furnace FC-2', '{"Meat": 14000000, "Wood": 14000000, "Coal": 2900000, "Iron": 720000, "FireCrystals": 39, "RefinedFireCrystals": 0}', '5d 22:33:00', 423566);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 8) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 8, 'Furnace FC-2', '{"Meat": 14000000, "Wood": 14000000, "Coal": 2900000, "Iron": 720000, "FireCrystals": 39, "RefinedFireCrystals": 0}', '5d 22:33:00', 436194);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 9) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 9, 'Furnace FC-2', '{"Meat": 14000000, "Wood": 14000000, "Coal": 2900000, "Iron": 720000, "FireCrystals": 39, "RefinedFireCrystals": 0}', '5d 22:33:00', 448822);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 10) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 10, 'Furnace FC-2', '{"Meat": 14000000, "Wood": 14000000, "Coal": 2900000, "Iron": 1000000, "FireCrystals": 39, "RefinedFireCrystals": 0}', '5d 22:33:00', 461450);
    END IF;
    
    -- Levels 11-15 (FC2-1 through FC 3)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 11) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 11, 'Furnace FC-3', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 790000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '7d 06:14:00', 474087);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 12) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 12, 'Furnace FC-3', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 790000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '7d 06:14:00', 486706);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 13) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 13, 'Furnace FC-3', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 790000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '7d 06:14:00', 499334);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 14) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 14, 'Furnace FC-3', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 790000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '7d 06:14:00', 511962);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 15) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 15, 'Furnace FC-3', '{"Meat": 15000000, "Wood": 15000000, "Coal": 3100000, "Iron": 790000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '7d 06:14:00', 524590);
    END IF;
    
    -- Levels 16-20 (FC 3-1 through FC 4)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 16) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 16, 'Furnace FC-4', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 820000, "FireCrystals": 70, "RefinedFireCrystals": 0}', '7d 22:04:00', 538494);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 17) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 17, 'Furnace FC-4', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 820000, "FireCrystals": 70, "RefinedFireCrystals": 0}', '7d 22:04:00', 552398);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 18) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 18, 'Furnace FC-4', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 820000, "FireCrystals": 70, "RefinedFireCrystals": 0}', '7d 22:04:00', 566302);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 19) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 19, 'Furnace FC-4', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 820000, "FireCrystals": 70, "RefinedFireCrystals": 0}', '7d 22:04:00', 580206);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 20) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 20, 'Furnace FC-4', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3200000, "Iron": 820000, "FireCrystals": 70, "RefinedFireCrystals": 0}', '7d 22:04:00', 594110);
    END IF;
    
    -- Levels 21-25 (FC 4-1 through FC 5)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 21) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 21, 'Furnace FC-5', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3300000, "Iron": 840000, "FireCrystals": 83, "RefinedFireCrystals": 0}', '9d 05:45:00', 608014);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 22) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 22, 'Furnace FC-5', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3300000, "Iron": 840000, "FireCrystals": 83, "RefinedFireCrystals": 0}', '9d 05:45:00', 621918);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 23) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 23, 'Furnace FC-5', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3300000, "Iron": 840000, "FireCrystals": 83, "RefinedFireCrystals": 0}', '9d 05:45:00', 635822);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 24) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 24, 'Furnace FC-5', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3300000, "Iron": 840000, "FireCrystals": 83, "RefinedFireCrystals": 0}', '9d 05:45:00', 649726);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 25) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 25, 'Furnace FC-5', '{"Meat": 16000000, "Wood": 16000000, "Coal": 3300000, "Iron": 840000, "FireCrystals": 83, "RefinedFireCrystals": 0}', '9d 05:45:00', 663630);
    END IF;
    
    -- Levels 26-30 (FC 5.1 through FC 6)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 26) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 26, 'Furnace FC-6', '{"Meat": 19000000, "Wood": 19000000, "Coal": 3800000, "Iron": 960000, "FireCrystals": 50, "RefinedFireCrystals": 2}', '9d 21:36:00', 678502);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 27) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 27, 'Furnace FC-6', '{"Meat": 19000000, "Wood": 19000000, "Coal": 3800000, "Iron": 960000, "FireCrystals": 50, "RefinedFireCrystals": 2}', '9d 21:36:00', 693374);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 28) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 28, 'Furnace FC-6', '{"Meat": 19000000, "Wood": 19000000, "Coal": 3800000, "Iron": 960000, "FireCrystals": 50, "RefinedFireCrystals": 2}', '9d 21:36:00', 708246);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 29) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 29, 'Furnace FC-6', '{"Meat": 19000000, "Wood": 19000000, "Coal": 3800000, "Iron": 960000, "FireCrystals": 50, "RefinedFireCrystals": 2}', '9d 21:36:00', 723118);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 30) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 30, 'Furnace FC-6', '{"Meat": 19000000, "Wood": 19000000, "Coal": 3800000, "Iron": 960000, "FireCrystals": 25, "RefinedFireCrystals": 5}', '9d 21:36:00', 737990);
    END IF;
    
    -- Levels 31-35 (FC 6.1 through FC 7)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 31) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 31, 'Furnace FC-7', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 60, "RefinedFireCrystals": 3}', '11d 21:07:00', 752862);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 32) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 32, 'Furnace FC-7', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 60, "RefinedFireCrystals": 3}', '11d 21:07:00', 767734);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 33) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 33, 'Furnace FC-7', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 60, "RefinedFireCrystals": 3}', '11d 21:07:00', 782606);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 34) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 34, 'Furnace FC-7', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 60, "RefinedFireCrystals": 3}', '11d 21:07:00', 797478);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 35) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 35, 'Furnace FC-7', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 30, "RefinedFireCrystals": 7}', '11d 21:07:00', 812350);
    END IF;
    
    -- Levels 36-40 (FC 7.1 through FC 8)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 36) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 36, 'Furnace FC-8', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 60, "RefinedFireCrystals": 5}', '13d 04:48:00', 827222);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 37) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 37, 'Furnace FC-8', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 60, "RefinedFireCrystals": 5}', '13d 04:48:00', 842094);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 38) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 38, 'Furnace FC-8', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 60, "RefinedFireCrystals": 5}', '13d 04:48:00', 856966);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 39) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 39, 'Furnace FC-8', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 60, "RefinedFireCrystals": 5}', '13d 04:48:00', 871838);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 40) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 40, 'Furnace FC-8', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 30, "RefinedFireCrystals": 10}', '13d 04:48:00', 886710);
    END IF;
    
    -- Levels 41-45 (FC 8.1 through FC 9)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 41) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 41, 'Furnace FC-9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1400000, "FireCrystals": 70, "RefinedFireCrystals": 7}', '8d 13:55:00', 902638);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 42) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 42, 'Furnace FC-9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1400000, "FireCrystals": 70, "RefinedFireCrystals": 7}', '8d 13:55:00', 918566);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 43) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 43, 'Furnace FC-9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1400000, "FireCrystals": 70, "RefinedFireCrystals": 7}', '8d 13:55:00', 934494);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 44) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 44, 'Furnace FC-9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1400000, "FireCrystals": 70, "RefinedFireCrystals": 7}', '8d 13:55:00', 950422);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 45) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 45, 'Furnace FC-9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1400000, "FireCrystals": 35, "RefinedFireCrystals": 15}', '8d 13:55:00', 966350);
    END IF;
    
    -- Levels 46-50 (FC 9.1 through FC 10)
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 46) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 46, 'Furnace FC-10', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 87, "RefinedFireCrystals": 17}', '13d 04:48:00', 982278);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 47) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 47, 'Furnace FC-10', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 87, "RefinedFireCrystals": 17}', '13d 04:48:00', 998206);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 48) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 48, 'Furnace FC-10', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 87, "RefinedFireCrystals": 17}', '13d 04:48:00', 1014134);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 49) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 49, 'Furnace FC-10', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 87, "RefinedFireCrystals": 17}', '13d 04:48:00', 1030062);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'FC-Embassy' AND level = 50) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
        VALUES ('FC-Embassy', 50, 'Furnace FC-10', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 43, "RefinedFireCrystals": 35}', '13d 04:48:00', 1045990);
    END IF;
    
    -- Fire Crystal Command Center
    IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'Command-Center') THEN
        INSERT INTO buildings (name, type, base_cost, base_power, max_level, description) VALUES
        ('Command-Center', 'advanced', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132}', 1580900, 50, 'Fire Crystal enhanced Command Center for superior leadership');
    ELSE
        UPDATE buildings SET max_level = 50 WHERE name = 'Command-Center';
    END IF;
END $$;

-- Command Center Levels 1-5 (30-1 through FC 1)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 1) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 1, 'Embassy FC-1, Furnace FC-1', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000, "FireCrystals": 26, "RefinedFireCrystals": 0}', '20:09:30', 221326);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 2) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 2, 'Embassy FC-1, Furnace FC-1', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000, "FireCrystals": 26, "RefinedFireCrystals": 0}', '20:09:30', 229362);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 3) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 3, 'Embassy FC-1, Furnace FC-1', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000, "FireCrystals": 26, "RefinedFireCrystals": 0}', '20:09:30', 237398);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 4) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 4, 'Embassy FC-1, Furnace FC-1', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000, "FireCrystals": 26, "RefinedFireCrystals": 0}', '20:09:30', 245434);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 5) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 5, 'Embassy FC-1, Furnace FC-1', '{"Meat": 20000000, "Wood": 20000000, "Coal": 4000000, "Iron": 1000000, "FireCrystals": 26, "RefinedFireCrystals": 0}', '20:09:30', 253470);
END IF;
END $$;

-- Levels 6-10 (FC1-1 through FC 2)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 6) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 6, 'Embassy FC-2, Furnace FC-2', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 31, "RefinedFireCrystals": 0}', '1d 01:55:00', 261506);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 7) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 7, 'Embassy FC-2, Furnace FC-2', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 31, "RefinedFireCrystals": 0}', '1d 01:55:00', 269542);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 8) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 8, 'Embassy FC-2, Furnace FC-2', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 31, "RefinedFireCrystals": 0}', '1d 01:55:00', 277578);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 9) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 9, 'Embassy FC-2, Furnace FC-2', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 31, "RefinedFireCrystals": 0}', '1d 01:55:00', 285614);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 10) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 10, 'Embassy FC-2, Furnace FC-2', '{"Meat": 21000000, "Wood": 21000000, "Coal": 4300000, "Iron": 1000000, "FireCrystals": 31, "RefinedFireCrystals": 0}', '1d 01:55:00', 293650);
END IF;
END $$;

-- Levels 11-15 (FC2-1 through FC 3)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 11) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 11, 'Embassy FC-3, Furnace FC-3', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 47, "RefinedFireCrystals": 0}', '1d 07:40:00', 301686);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 12) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 12, 'Embassy FC-3, Furnace FC-3', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 47, "RefinedFireCrystals": 0}', '1d 07:40:00', 309722);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 13) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 13, 'Embassy FC-3, Furnace FC-3', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 47, "RefinedFireCrystals": 0}', '1d 07:40:00', 317758);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 14) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 14, 'Embassy FC-3, Furnace FC-3', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 47, "RefinedFireCrystals": 0}', '1d 07:40:00', 325794);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 15) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 15, 'Embassy FC-3, Furnace FC-3', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 47, "RefinedFireCrystals": 0}', '1d 07:40:00', 333830);
END IF;
END $$;

-- Levels 16-20 (FC 3-1 through FC 4)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 16) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 16, 'Embassy FC-4, Furnace FC-4', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000, "FireCrystals": 56, "RefinedFireCrystals": 0}', '1d 10:33:00', 342678);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 17) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 17, 'Embassy FC-4, Furnace FC-3', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000, "FireCrystals": 56, "RefinedFireCrystals": 0}', '1d 10:33:00', 351526);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 18) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 18, 'Embassy FC-4, Furnace FC-3', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000, "FireCrystals": 56, "RefinedFireCrystals": 0}', '1d 10:33:00', 360374);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 19) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 19, 'Embassy FC-4, Furnace FC-3', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000, "FireCrystals": 56, "RefinedFireCrystals": 0}', '1d 10:33:00', 369222);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 20) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 20, 'Embassy FC-4, Furnace FC-3', '{"Meat": 24000000, "Wood": 24000000, "Coal": 4900000, "Iron": 1200000, "FireCrystals": 56, "RefinedFireCrystals": 0}', '1d 10:33:00', 378070);
END IF;
END $$;

-- Levels 21-25 (FC 4-1 through FC 5)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 21) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 21, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 386918);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 22) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 22, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 395766);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 23) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 23, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 404614);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 24) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 24, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 413462);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 25) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 25, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 422310);
END IF;
END $$;

-- Levels 26-30 (FC 5.1 through FC 6)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 26) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 26, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 431158);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 27) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 27, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 440006);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 28) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 28, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 448854);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 29) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 29, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 457702);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 30) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 30, 'Embassy FC Lv. 5, Furnace FC Lv. 5', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 67, "RefinedFireCrystals": 0}', '1d 16:31:00', 466550);
END IF;
END $$;

-- Levels 31-35 (FC 6.1 through FC 7)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 31) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 31, 'Embassy FC Lv. 6, Furnace FC Lv. 6', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000, "FireCrystals": 80, "RefinedFireCrystals": 0}', '2d 01:29:00', 475398);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 32) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 32, 'Embassy FC Lv. 6, Furnace FC Lv. 6', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000, "FireCrystals": 80, "RefinedFireCrystals": 0}', '2d 01:29:00', 484246);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 33) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 33, 'Embassy FC Lv. 6, Furnace FC Lv. 6', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000, "FireCrystals": 80, "RefinedFireCrystals": 0}', '2d 01:29:00', 493094);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 34) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 34, 'Embassy FC Lv. 6, Furnace FC Lv. 6', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000, "FireCrystals": 80, "RefinedFireCrystals": 0}', '2d 01:29:00', 501942);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 35) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 35, 'Embassy FC Lv. 6, Furnace FC Lv. 6', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5200000, "Iron": 1300000, "FireCrystals": 80, "RefinedFireCrystals": 0}', '2d 01:29:00', 510790);
END IF;
END $$;

-- Levels 36-40 (FC 7.1 through FC 8)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 36) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 36, 'Embassy FC Lv. 7, Furnace FC Lv. 7', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5400000, "Iron": 1400000, "FireCrystals": 95, "RefinedFireCrystals": 0}', '2d 10:27:00', 519638);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 37) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 37, 'Embassy FC Lv. 7, Furnace FC Lv. 7', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5400000, "Iron": 1400000, "FireCrystals": 95, "RefinedFireCrystals": 0}', '2d 10:27:00', 528486);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 38) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 38, 'Embassy FC Lv. 7, Furnace FC Lv. 7', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5400000, "Iron": 1400000, "FireCrystals": 95, "RefinedFireCrystals": 0}', '2d 10:27:00', 537334);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 39) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 39, 'Embassy FC Lv. 7, Furnace FC Lv. 7', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5400000, "Iron": 1400000, "FireCrystals": 95, "RefinedFireCrystals": 0}', '2d 10:27:00', 546182);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 40) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 40, 'Embassy FC Lv. 7, Furnace FC Lv. 7', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5400000, "Iron": 1400000, "FireCrystals": 95, "RefinedFireCrystals": 0}', '2d 10:27:00', 555030);
END IF;
END $$;

-- Levels 41-45 (FC 8.1 through FC 9)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 41) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 41, 'Embassy FC Lv. 8, Furnace FC Lv. 8', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5600000, "Iron": 1500000, "FireCrystals": 112, "RefinedFireCrystals": 0}', '3d 04:25:00', 563878);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 42) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 42, 'Embassy FC Lv. 8, Furnace FC Lv. 8', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5600000, "Iron": 1500000, "FireCrystals": 112, "RefinedFireCrystals": 0}', '3d 04:25:00', 572726);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 43) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 43, 'Embassy FC Lv. 8, Furnace FC Lv. 8', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5600000, "Iron": 1500000, "FireCrystals": 112, "RefinedFireCrystals": 0}', '3d 04:25:00', 581574);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 44) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 44, 'Embassy FC Lv. 8, Furnace FC Lv. 8', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5600000, "Iron": 1500000, "FireCrystals": 112, "RefinedFireCrystals": 0}', '3d 04:25:00', 590422);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 45) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 45, 'Embassy FC Lv. 8, Furnace FC Lv. 8', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5600000, "Iron": 1500000, "FireCrystals": 112, "RefinedFireCrystals": 0}', '3d 04:25:00', 599270);
END IF;
END $$;

-- Levels 46-50 (FC 9.1 through FC 10)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 46) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 46, 'Embassy FC Lv. 9, Furnace FC Lv. 9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1600000, "FireCrystals": 131, "RefinedFireCrystals": 0}', '4d 07:23:00', 608118);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 47) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 47, 'Embassy FC Lv. 9, Furnace FC Lv. 9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1600000, "FireCrystals": 131, "RefinedFireCrystals": 0}', '4d 07:23:00', 616966);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 48) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 48, 'Embassy FC Lv. 9, Furnace FC Lv. 9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1600000, "FireCrystals": 131, "RefinedFireCrystals": 0}', '4d 07:23:00', 625814);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 49) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 49, 'Embassy FC Lv. 9, Furnace FC Lv. 9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1600000, "FireCrystals": 131, "RefinedFireCrystals": 0}', '4d 07:23:00', 634662);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Command-Center' AND level = 50) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Command-Center', 50, 'Embassy FC Lv. 9, Furnace FC Lv. 9', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5800000, "Iron": 1600000, "FireCrystals": 131, "RefinedFireCrystals": 0}', '4d 07:23:00', 643510);
END IF;
END $$;

-- Fire Crystal Marksman Camp building
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'Fire Crystal Marksman Camp') THEN
    INSERT INTO buildings (name, type, base_cost, base_power, max_level, description)
    VALUES ('Fire Crystal Marksman Camp', 'military', '{"Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', 316180, 50, 'Fire Crystal training facility for marksmen');
END IF;
END $$;

-- Fire Crystal Marksman Camp levels 1-5 (30-1 through FC 1)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 1) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 1, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 316180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 2) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 2, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 327660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 3) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 3, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 339140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 4) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 4, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 350620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 5) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 5, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 362100);
END IF;
END $$;

-- Levels 6-10 (FC1-1 through FC 2)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 6) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 6, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 373580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 7) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 7, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 21000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 385060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 8) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 8, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 396540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 9) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 9, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 408020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 10) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 10, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 419500);
END IF;
END $$;

-- Levels 11-15 (FC2-1 through FC 3)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 11) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 11, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 430980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 12) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 12, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 442460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 13) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 13, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 453940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 14) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 14, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 465420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 15) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 15, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 476900);
END IF;
END $$;

-- Levels 16-20 (FC 3-1 through FC 4)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 16) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 16, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 489540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 17) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 17, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 502180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 18) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 18, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 514820);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 19) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 19, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 527460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 20) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 20, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 540100);
END IF;
END $$;

-- Levels 21-25 (FC 4-1 through FC 5)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 21) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 21, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 552740);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 22) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 22, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 565380);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 23) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 23, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 578020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 24) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 24, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 590660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 25) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 25, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 603300);
END IF;
END $$;

-- Levels 26-30 (FC 5.1 through FC 6)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 26) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 26, 'Furnace FC-5', '{"Meat": 30000000, "Wood": 30000000, "Coal": 6100000, "Iron": 1500000, "FireCrystals": 178, "RefinedFireCrystals": 0}', '2d 09:36:00', 615940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 27) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 27, 'Furnace FC-6', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000, "FireCrystals": 211, "RefinedFireCrystals": 0}', '2d 16:48:00', 628580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 28) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 28, 'Furnace FC-6', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 07:12:00', 641220);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 29) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 29, 'Furnace FC-7', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 21:36:00', 653860);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 30) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 30, 'Furnace FC-7', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '4d 12:00:00', 666500);
END IF;
END $$;

-- Levels 31-40 (FC 7.2 through FC 8.4)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 31) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 31, 'Furnace FC-7', '{"Meat": 35000000, "Wood": 35000000, "Coal": 7100000, "Iron": 1700000, "FireCrystals": 414, "RefinedFireCrystals": 0}', '5d 02:24:00', 679140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 32) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 32, 'Furnace FC-8', '{"Meat": 36000000, "Wood": 36000000, "Coal": 7300000, "Iron": 1800000, "FireCrystals": 489, "RefinedFireCrystals": 0}', '5d 16:48:00', 691780);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 33) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 33, 'Furnace FC-8', '{"Meat": 37000000, "Wood": 37000000, "Coal": 7500000, "Iron": 1800000, "FireCrystals": 578, "RefinedFireCrystals": 0}', '6d 07:12:00', 704420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 34) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 34, 'Furnace FC-8', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7700000, "Iron": 1900000, "FireCrystals": 683, "RefinedFireCrystals": 0}', '6d 21:36:00', 717060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 35) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 35, 'Furnace FC-8', '{"Meat": 39000000, "Wood": 39000000, "Coal": 7900000, "Iron": 1900000, "FireCrystals": 807, "RefinedFireCrystals": 0}', '7d 12:00:00', 729700);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 36) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 36, 'Furnace FC-8', '{"Meat": 40000000, "Wood": 40000000, "Coal": 8100000, "Iron": 2000000, "FireCrystals": 954, "RefinedFireCrystals": 0}', '8d 02:24:00', 742340);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 37) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 37, 'Furnace FC-9', '{"Meat": 41000000, "Wood": 41000000, "Coal": 8300000, "Iron": 2000000, "FireCrystals": 1127, "RefinedFireCrystals": 0}', '8d 16:48:00', 754980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 38) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 38, 'Furnace FC-9', '{"Meat": 42000000, "Wood": 42000000, "Coal": 8500000, "Iron": 2100000, "FireCrystals": 1331, "RefinedFireCrystals": 0}', '9d 07:12:00', 767620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 39) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 39, 'Furnace FC-9', '{"Meat": 43000000, "Wood": 43000000, "Coal": 8700000, "Iron": 2100000, "FireCrystals": 1572, "RefinedFireCrystals": 0}', '9d 21:36:00', 780260);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 40) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 40, 'Furnace FC-9', '{"Meat": 44000000, "Wood": 44000000, "Coal": 8900000, "Iron": 2200000, "FireCrystals": 1857, "RefinedFireCrystals": 0}', '10d 12:00:00', 792900);
END IF;
END $$;

-- Levels 41-50 (FC 9.4 through FC 10)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 41) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 41, 'Furnace FC-9', '{"Meat": 45000000, "Wood": 45000000, "Coal": 9100000, "Iron": 2200000, "FireCrystals": 2194, "RefinedFireCrystals": 0}', '11d 02:24:00', 805540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 42) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 42, 'Furnace FC-10', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 2593, "RefinedFireCrystals": 0}', '11d 16:48:00', 818180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 43) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 43, 'Furnace FC-10', '{"Meat": 47000000, "Wood": 47000000, "Coal": 9500000, "Iron": 2300000, "FireCrystals": 3064, "RefinedFireCrystals": 0}', '12d 07:12:00', 830820);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 44) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 44, 'Furnace FC-10', '{"Meat": 48000000, "Wood": 48000000, "Coal": 9700000, "Iron": 2400000, "FireCrystals": 3619, "RefinedFireCrystals": 0}', '12d 21:36:00', 843460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 45) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 45, 'Furnace FC-10', '{"Meat": 49000000, "Wood": 49000000, "Coal": 9900000, "Iron": 2400000, "FireCrystals": 4278, "RefinedFireCrystals": 0}', '13d 12:00:00', 856100);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 46) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 46, 'Furnace FC-10', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10100000, "Iron": 2500000, "FireCrystals": 5058, "RefinedFireCrystals": 0}', '14d 02:24:00', 868740);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 47) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 47, 'Furnace FC-10', '{"Meat": 51000000, "Wood": 51000000, "Coal": 10300000, "Iron": 2500000, "FireCrystals": 5982, "RefinedFireCrystals": 0}', '14d 16:48:00', 881380);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 48) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 48, 'Furnace FC-10', '{"Meat": 52000000, "Wood": 52000000, "Coal": 10500000, "Iron": 2600000, "FireCrystals": 7077, "RefinedFireCrystals": 0}', '15d 07:12:00', 894020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 49) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 49, 'Furnace FC-10', '{"Meat": 53000000, "Wood": 53000000, "Coal": 10700000, "Iron": 2600000, "FireCrystals": 8370, "RefinedFireCrystals": 0}', '15d 21:36:00', 906660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Marksman Camp' AND level = 50) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Marksman Camp', 50, 'Furnace FC-10', '{"Meat": 54000000, "Wood": 54000000, "Coal": 10900000, "Iron": 2700000, "FireCrystals": 9895, "RefinedFireCrystals": 0}', '16d 12:00:00', 919300);
END IF;
END $$;

-- Fire Crystal Lancer Camp building
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'Fire Crystal Lancer Camp') THEN
    INSERT INTO buildings (name, type, base_cost, base_power, max_level, description)
    VALUES ('Fire Crystal Lancer Camp', 'military', '{"Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', 316180, 50, 'Fire Crystal training facility for lancers');
END IF;
END $$;

-- Fire Crystal Lancer Camp levels 1-5 (30-1 through FC 1)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 1) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 1, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 316180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 2) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 2, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 327660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 3) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 3, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 339140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 4) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 4, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 350620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 5) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 5, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 362100);
END IF;
END $$;

-- Fire Crystal Lancer Camp levels 6-25 (FC1-1 through FC 5)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 6) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 6, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5100000, "Iron": 1200000, "FireCrystals": 72, "RefinedFireCrystals": 0}', '1d 07:12:00', 373580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 7) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 7, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5100000, "Iron": 1200000, "FireCrystals": 36, "RefinedFireCrystals": 2}', '1d 07:12:00', 385060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 8) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 8, 'Furnace FC-3', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 81, "RefinedFireCrystals": 0}', '1d 12:00:00', 396540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 9) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 9, 'Furnace FC-3', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 40, "RefinedFireCrystals": 3}', '1d 12:00:00', 408020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 10) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 10, 'Furnace FC-3', '{"Meat": 26000000, "Wood": 26000000, "Coal": 5300000, "Iron": 1300000, "FireCrystals": 81, "RefinedFireCrystals": 0}', '1d 12:00:00', 419500);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 11) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 11, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 45, "RefinedFireCrystals": 4}', '1d 19:12:00', 430980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 12) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 12, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 442460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 13) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 13, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 453940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 14) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 14, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 465420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 15) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 15, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 476900);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 16) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 16, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 488380);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 17) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 17, 'Furnace FC-6', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 90, "RefinedFireCrystals": 4}', '2d 06:00:00', 499860);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 18) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 18, 'Furnace FC-6', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 90, "RefinedFireCrystals": 4}', '2d 06:00:00', 511340);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 19) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 19, 'Furnace FC-6', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 90, "RefinedFireCrystals": 4}', '2d 06:00:00', 522820);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 20) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 20, 'Furnace FC-6', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 90, "RefinedFireCrystals": 4}', '2d 06:00:00', 534300);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 21) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 21, 'Furnace FC-6', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 45, "RefinedFireCrystals": 9}', '2d 06:00:00', 545780);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 22) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 22, 'Furnace FC-7', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7600000, "Iron": 1900000, "FireCrystals": 108, "RefinedFireCrystals": 6}', '2d 16:48:00', 557260);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 23) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 23, 'Furnace FC-7', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7600000, "Iron": 1900000, "FireCrystals": 108, "RefinedFireCrystals": 6}', '2d 16:48:00', 568740);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 24) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 24, 'Furnace FC-7', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7600000, "Iron": 1900000, "FireCrystals": 108, "RefinedFireCrystals": 6}', '2d 16:48:00', 580220);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 25) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 25, 'Furnace FC-7', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7600000, "Iron": 1900000, "FireCrystals": 108, "RefinedFireCrystals": 6}', '2d 16:48:00', 591700);
END IF;
END $$;

-- Fire Crystal Lancer Camp levels 26-40 (FC 7 through FC 9.3)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 26) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 26, 'Furnace FC-7', '{"Meat": 38000000, "Wood": 38000000, "Coal": 7600000, "Iron": 1900000, "FireCrystals": 54, "RefinedFireCrystals": 13}', '2d 16:48:00', 603180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 27) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 27, 'Furnace FC-8', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 108, "RefinedFireCrystals": 9}', '3d 00:00:00', 614660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 28) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 28, 'Furnace FC-8', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 108, "RefinedFireCrystals": 9}', '3d 00:00:00', 626140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 29) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 29, 'Furnace FC-8', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 108, "RefinedFireCrystals": 9}', '3d 00:00:00', 637620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 30) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 30, 'Furnace FC-8', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 108, "RefinedFireCrystals": 9}', '3d 00:00:00', 649100);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 31) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 31, 'Furnace FC-8', '{"Meat": 46000000, "Wood": 46000000, "Coal": 9300000, "Iron": 2300000, "FireCrystals": 54, "RefinedFireCrystals": 18}', '3d 00:00:00', 660580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 32) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 32, 'Furnace FC-9', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10000000, "Iron": 2500000, "FireCrystals": 126, "RefinedFireCrystals": 13}', '1d 22:48:00', 672060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 33) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 33, 'Furnace FC-9', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10000000, "Iron": 2500000, "FireCrystals": 126, "RefinedFireCrystals": 13}', '1d 22:48:00', 683540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 34) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 34, 'Furnace FC-9', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10000000, "Iron": 2500000, "FireCrystals": 126, "RefinedFireCrystals": 13}', '1d 22:48:00', 695020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 35) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 35, 'Furnace FC-9', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10000000, "Iron": 2500000, "FireCrystals": 126, "RefinedFireCrystals": 13}', '1d 22:48:00', 706500);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 36) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 36, 'Furnace FC-9', '{"Meat": 50000000, "Wood": 50000000, "Coal": 10000000, "Iron": 2500000, "FireCrystals": 63, "RefinedFireCrystals": 27}', '1d 22:48:00', 717980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 37) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 37, 'Furnace FC-10', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000, "FireCrystals": 157, "RefinedFireCrystals": 31}', '3d 00:00:00', 729460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 38) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 38, 'Furnace FC-10', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000, "FireCrystals": 157, "RefinedFireCrystals": 31}', '3d 00:00:00', 740940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 39) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 39, 'Furnace FC-10', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000, "FireCrystals": 157, "RefinedFireCrystals": 31}', '3d 00:00:00', 752420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 40) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 40, 'Furnace FC-10', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000, "FireCrystals": 157, "RefinedFireCrystals": 31}', '3d 00:00:00', 763900);
END IF;
END $$;

-- Fire Crystal Lancer Camp final level (FC 10)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Lancer Camp' AND level = 50) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Lancer Camp', 50, 'Furnace FC-10', '{"Meat": 59000000, "Wood": 59000000, "Coal": 11000000, "Iron": 2900000, "FireCrystals": 78, "RefinedFireCrystals": 63}', '3d 00:00:00', 950900);
END IF;
END $$;

-- Fire Crystal Infantry Camp building
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM buildings WHERE name = 'Fire Crystal Infantry Camp') THEN
    INSERT INTO buildings (name, type, base_cost, base_power, max_level, description)
    VALUES ('Fire Crystal Infantry Camp', 'military', '{"Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', 316180, 50, 'Fire Crystal training facility for infantry');
END IF;
END $$;

-- Fire Crystal Infantry Camp levels 1-10 (30-1 through FC1-4)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 1) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 1, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 316180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 2) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 2, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 327660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 3) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 3, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 339140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 4) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 4, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 350620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 5) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 5, 'Furnace FC-1', '{"Meat": 23000000, "Wood": 23000000, "Coal": 4700000, "Iron": 1100000, "FireCrystals": 59, "RefinedFireCrystals": 0}', '1d 01:12:00', 362100);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 6) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 6, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 373580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 7) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 7, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 21000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 385060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 8) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 8, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 396540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 9) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 9, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 408020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 10) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 10, 'Furnace FC-2', '{"Meat": 25000000, "Wood": 25000000, "Coal": 5000000, "Iron": 1200000, "FireCrystals": 71, "RefinedFireCrystals": 0}', '1d 08:24:00', 419500);
END IF;
END $$;

-- Fire Crystal Infantry Camp levels 11-25 (FC2-1 through FC 5)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 11) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 11, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 430980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 12) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 12, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 442460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 13) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 13, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 453940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 14) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 14, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 465420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 15) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 15, 'Furnace FC-3', '{"Meat": 27000000, "Wood": 27000000, "Coal": 5500000, "Iron": 1300000, "FireCrystals": 107, "RefinedFireCrystals": 0}', '1d 15:36:00', 476900);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 16) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 16, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 489540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 17) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 17, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 502180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 18) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 18, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 514820);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 19) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 19, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 527460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 20) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 20, 'Furnace FC-4', '{"Meat": 28000000, "Wood": 28000000, "Coal": 5700000, "Iron": 1400000, "FireCrystals": 126, "RefinedFireCrystals": 0}', '1d 19:12:00', 540100);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 21) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 21, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 552740);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 22) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 22, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 565380);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 23) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 23, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 578020);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 24) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 24, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 590660);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 25) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 25, 'Furnace FC-5', '{"Meat": 29000000, "Wood": 29000000, "Coal": 5900000, "Iron": 1400000, "FireCrystals": 150, "RefinedFireCrystals": 0}', '2d 02:24:00', 603300);
END IF;
END $$;

-- Fire Crystal Infantry Camp levels 26-40 (FC 5.1 through FC 9.3)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 26) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 26, 'Furnace FC-6', '{"Meat": 30000000, "Wood": 30000000, "Coal": 6100000, "Iron": 1500000, "FireCrystals": 178, "RefinedFireCrystals": 0}', '2d 09:36:00', 615940);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 27) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 27, 'Furnace FC-6', '{"Meat": 30000000, "Wood": 30000000, "Coal": 6100000, "Iron": 1500000, "FireCrystals": 178, "RefinedFireCrystals": 0}', '2d 09:36:00', 628580);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 28) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 28, 'Furnace FC-7', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000, "FireCrystals": 211, "RefinedFireCrystals": 0}', '2d 16:48:00', 641220);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 29) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 29, 'Furnace FC-7', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000, "FireCrystals": 211, "RefinedFireCrystals": 0}', '2d 16:48:00', 653860);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 30) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 30, 'Furnace FC-7', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000, "FireCrystals": 211, "RefinedFireCrystals": 0}', '2d 16:48:00', 666500);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 31) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 31, 'Furnace FC-7', '{"Meat": 31000000, "Wood": 31000000, "Coal": 6300000, "Iron": 1500000, "FireCrystals": 211, "RefinedFireCrystals": 0}', '2d 16:48:00', 679140);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 32) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 32, 'Furnace FC-8', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 00:00:00', 691780);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 33) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 33, 'Furnace FC-8', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 00:00:00', 704420);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 34) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 34, 'Furnace FC-8', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 00:00:00', 717060);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 35) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 35, 'Furnace FC-8', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 00:00:00', 729700);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 36) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 36, 'Furnace FC-8', '{"Meat": 32000000, "Wood": 32000000, "Coal": 6500000, "Iron": 1600000, "FireCrystals": 250, "RefinedFireCrystals": 0}', '3d 00:00:00', 742340);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 37) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 37, 'Furnace FC-9', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 07:12:00', 754980);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 38) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 38, 'Furnace FC-9', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 07:12:00', 767620);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 39) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 39, 'Furnace FC-9', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 07:12:00', 780260);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 40) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 40, 'Furnace FC-9', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 07:12:00', 792900);
END IF;
END $$;

-- Fire Crystal Infantry Camp levels 41-50 (FC 9 through FC 10)
DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 41) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 41, 'Furnace FC-9', '{"Meat": 33000000, "Wood": 33000000, "Coal": 6700000, "Iron": 1600000, "FireCrystals": 296, "RefinedFireCrystals": 0}', '3d 07:12:00', 805540);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 42) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 42, 'Furnace FC-10', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '3d 14:24:00', 818180);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 43) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 43, 'Furnace FC-10', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '3d 14:24:00', 830820);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 44) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 44, 'Furnace FC-10', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '3d 14:24:00', 843460);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 45) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 45, 'Furnace FC-10', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '3d 14:24:00', 856100);
END IF;
END $$;

DO $$ BEGIN
IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Infantry Camp' AND level = 46) THEN
    INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power)
    VALUES ('Fire Crystal Infantry Camp', 46, 'Furnace FC-10', '{"Meat": 34000000, "Wood": 34000000, "Coal": 6900000, "Iron": 1700000, "FireCrystals": 350, "RefinedFireCrystals": 0}', '3d 14:24:00', 868740);
END IF;
END $$;

-- Fire Crystal Furnace levels with correct naming
DO $$
BEGIN
    -- Level 30-1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 1) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 1, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1580900);
    END IF;
    
    -- Level 30-2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 2) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 2, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1638300);
    END IF;
    
    -- Level 30-3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 3) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 3, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1695700);
    END IF;
    
    -- Level 30-4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 4) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 4, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1753100);
    END IF;
    
    -- Level FC 1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 5) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 5, 'Embassy Lv. 30, Research Center Lv. 30', '{"Meat": 67000000, "Wood": 67000000, "Coal": 13000000, "Iron": 3300000, "FireCrystals": 132, "RefinedFireCrystals": 0}', '7d 00:00:00', 1810500);
    END IF;
END $$;

-- Continue with FC1-1 through FC1-4 and FC 2
DO $$
BEGIN
    -- Level FC1-1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 6) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 6, 'Embassy FC 1, Lancer Camp FC-1', '{"Meat": 72000000, "Wood": 72000000, "Coal": 14000000, "Iron": 3600000, "FireCrystals": 158, "RefinedFireCrystals": 0}', '9d 00:00:00', 1867900);
    END IF;
    
    -- Level FC1-2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 7) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 7, 'Embassy FC 1, Lancer Camp FC-1', '{"Meat": 72000000, "Wood": 72000000, "Coal": 14000000, "Iron": 3600000, "FireCrystals": 158, "RefinedFireCrystals": 0}', '9d 00:00:00', 1925300);
    END IF;
    
    -- Level FC1-3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 8) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 8, 'Embassy FC 1, Lancer Camp FC-1', '{"Meat": 72000000, "Wood": 72000000, "Coal": 14000000, "Iron": 3600000, "FireCrystals": 158, "RefinedFireCrystals": 0}', '9d 00:00:00', 1982700);
    END IF;
    
    -- Level FC1-4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 9) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 9, 'Embassy FC 1, Lancer Camp FC-1', '{"Meat": 72000000, "Wood": 72000000, "Coal": 14000000, "Iron": 3600000, "FireCrystals": 158, "RefinedFireCrystals": 0}', '9d 00:00:00', 2040100);
    END IF;
    
    -- Level FC 2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 10) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 10, 'Embassy FC 1, Lancer Camp FC-1', '{"Meat": 72000000, "Wood": 72000000, "Coal": 14000000, "Iron": 3600000, "FireCrystals": 158, "RefinedFireCrystals": 0}', '9d 00:00:00', 2097500);
    END IF;
END $$;

-- Continue with FC2-1 through FC2-4 and FC 3
DO $$
BEGIN
    -- Level FC2-1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 11) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 11, 'Embassy FC 2, Infantry Camp FC-2', '{"Meat": 79000000, "Wood": 79000000, "Coal": 15000000, "Iron": 3900000, "FireCrystals": 238, "RefinedFireCrystals": 0}', '11d 00:00:00', 2154900);
    END IF;
    
    -- Level FC2-2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 12) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 12, 'Embassy FC 2, Infantry Camp FC-2', '{"Meat": 79000000, "Wood": 79000000, "Coal": 15000000, "Iron": 3900000, "FireCrystals": 238, "RefinedFireCrystals": 0}', '11d 00:00:00', 2212300);
    END IF;
    
    -- Level FC2-3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 13) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 13, 'Embassy FC 2, Infantry Camp FC-2', '{"Meat": 79000000, "Wood": 79000000, "Coal": 15000000, "Iron": 3900000, "FireCrystals": 238, "RefinedFireCrystals": 0}', '11d 00:00:00', 2269700);
    END IF;
    
    -- Level FC2-4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 14) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 14, 'Embassy FC 2, Infantry Camp FC-2', '{"Meat": 79000000, "Wood": 79000000, "Coal": 15000000, "Iron": 3900000, "FireCrystals": 238, "RefinedFireCrystals": 0}', '11d 00:00:00', 2327100);
    END IF;
    
    -- Level FC 3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 15) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 15, 'Embassy FC 2, Infantry Camp FC-2', '{"Meat": 79000000, "Wood": 79000000, "Coal": 15000000, "Iron": 3900000, "FireCrystals": 238, "RefinedFireCrystals": 0}', '11d 00:00:00', 2384500);
    END IF;
END $$;

-- Continue with FC 3-1 through FC 3-4 and FC 4
DO $$
BEGIN
    -- Level FC 3-1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 16) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 16, 'Embassy FC 3, Marksman Camp FC 3', '{"Meat": 82000000, "Wood": 82000000, "Coal": 16000000, "Iron": 4100000, "FireCrystals": 280, "RefinedFireCrystals": 0}', '12d 00:00:00', 2447700);
    END IF;
    
    -- Level FC 3-2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 17) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 17, 'Embassy FC 3, Marksman Camp FC 3', '{"Meat": 82000000, "Wood": 82000000, "Coal": 16000000, "Iron": 4100000, "FireCrystals": 280, "RefinedFireCrystals": 0}', '12d 00:00:00', 2510900);
    END IF;
    
    -- Level FC 3-3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 18) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 18, 'Embassy FC 3, Marksman Camp FC 3', '{"Meat": 82000000, "Wood": 82000000, "Coal": 16000000, "Iron": 4100000, "FireCrystals": 280, "RefinedFireCrystals": 0}', '12d 00:00:00', 2574100);
    END IF;
    
    -- Level FC 3-4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 19) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 19, 'Embassy FC 3, Marksman Camp FC 3', '{"Meat": 82000000, "Wood": 82000000, "Coal": 16000000, "Iron": 4100000, "FireCrystals": 280, "RefinedFireCrystals": 0}', '12d 00:00:00', 2637300);
    END IF;
    
    -- Level FC 4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 20) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 20, 'Embassy FC 3, Marksman Camp FC 3', '{"Meat": 82000000, "Wood": 82000000, "Coal": 16000000, "Iron": 4100000, "FireCrystals": 280, "RefinedFireCrystals": 0}', '12d 00:00:00', 2700500);
    END IF;
END $$;

-- Continue with FC 4-1 through FC 4-4 and FC 5
DO $$
BEGIN
    -- Level FC 4-1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 21) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 21, 'Embassy FC 4, Lancer Camp FC 4', '{"Meat": 84000000, "Wood": 84000000, "Coal": 16000000, "Iron": 4200000, "FireCrystals": 335, "RefinedFireCrystals": 0}', '14d 00:00:00', 2763700);
    END IF;
    
    -- Level FC 4-2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 22) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 22, 'Embassy FC 4, Lancer Camp FC 4', '{"Meat": 84000000, "Wood": 84000000, "Coal": 16000000, "Iron": 4200000, "FireCrystals": 335, "RefinedFireCrystals": 0}', '14d 00:00:00', 2826900);
    END IF;
    
    -- Level FC 4-3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 23) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 23, 'Embassy FC 4, Lancer Camp FC 4', '{"Meat": 84000000, "Wood": 84000000, "Coal": 16000000, "Iron": 4200000, "FireCrystals": 335, "RefinedFireCrystals": 0}', '14d 00:00:00', 2890100);
    END IF;
    
    -- Level FC 4-4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 24) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 24, 'Embassy FC 4, Lancer Camp FC 4', '{"Meat": 84000000, "Wood": 84000000, "Coal": 16000000, "Iron": 4200000, "FireCrystals": 335, "RefinedFireCrystals": 0}', '14d 00:00:00', 2953300);
    END IF;
    
    -- Level FC 5
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 25) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 25, 'Embassy FC 4, Lancer Camp FC 4', '{"Meat": 84000000, "Wood": 84000000, "Coal": 16000000, "Iron": 4200000, "FireCrystals": 335, "RefinedFireCrystals": 0}', '14d 00:00:00', 3016500);
    END IF;
END $$;

-- Continue with FC 5.1 through FC 5.4 and FC 6 (now with Refined Fire Crystals)
DO $$
BEGIN
    -- Level FC 5.1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 26) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 26, 'Embassy FC 5, Infantry Camp FC 5', '{"Meat": 96000000, "Wood": 96000000, "Coal": 19000000, "Iron": 4800000, "FireCrystals": 200, "RefinedFireCrystals": 10}', '15d 00:00:00', 3084100);
    END IF;
    
    -- Level FC 5.2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 27) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 27, 'Embassy FC 5, Infantry Camp FC 5', '{"Meat": 96000000, "Wood": 96000000, "Coal": 19000000, "Iron": 4800000, "FireCrystals": 200, "RefinedFireCrystals": 10}', '15d 00:00:00', 3151700);
    END IF;
    
    -- Level FC 5.3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 28) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 28, 'Embassy FC 5, Infantry Camp FC 5', '{"Meat": 96000000, "Wood": 96000000, "Coal": 19000000, "Iron": 4800000, "FireCrystals": 200, "RefinedFireCrystals": 10}', '15d 00:00:00', 3219300);
    END IF;
    
    -- Level FC 5.4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 29) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 29, 'Embassy FC 5, Infantry Camp FC 5', '{"Meat": 96000000, "Wood": 96000000, "Coal": 19000000, "Iron": 4800000, "FireCrystals": 200, "RefinedFireCrystals": 10}', '15d 00:00:00', 3286900);
    END IF;
    
    -- Level FC 6
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 30) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 30, 'Embassy FC 5, Infantry Camp FC 5', '{"Meat": 96000000, "Wood": 96000000, "Coal": 19000000, "Iron": 4800000, "FireCrystals": 100, "RefinedFireCrystals": 20}', '15d 00:00:00', 3354500);
    END IF;
END $$;

-- Continue with FC 6.1 through FC 6.4 and FC 7
DO $$
BEGIN
    -- Level FC 6.1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 31) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 31, 'Embassy FC 6, Marksman Camp FC 6', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5400000, "FireCrystals": 240, "RefinedFireCrystals": 15}', '18d 00:00:00', 3422100);
    END IF;
    
    -- Level FC 6.2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 32) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 32, 'Embassy FC 6, Marksman Camp FC 6', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5400000, "FireCrystals": 240, "RefinedFireCrystals": 15}', '18d 00:00:00', 3489700);
    END IF;
    
    -- Level FC 6.3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 33) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 33, 'Embassy FC 6, Marksman Camp FC 6', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5400000, "FireCrystals": 240, "RefinedFireCrystals": 15}', '18d 00:00:00', 3557300);
    END IF;
    
    -- Level FC 6.4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 34) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 34, 'Embassy FC 6, Marksman Camp FC 6', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5400000, "FireCrystals": 240, "RefinedFireCrystals": 15}', '18d 00:00:00', 3624900);
    END IF;
    
    -- Level FC 7
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 35) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 35, 'Embassy FC 6, Marksman Camp FC 6', '{"Meat": 100000000, "Wood": 100000000, "Coal": 21000000, "Iron": 5400000, "FireCrystals": 120, "RefinedFireCrystals": 30}', '18d 00:00:00', 3692500);
    END IF;
END $$;

-- Continue with FC 7.1 through FC 7.4 and FC 8
DO $$
BEGIN
    -- Level FC 7.1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 36) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 36, 'Embassy FC 7, Lancer Camp FC 7', '{"Meat": 130000000, "Wood": 130000000, "Coal": 26000000, "Iron": 6600000, "FireCrystals": 240, "RefinedFireCrystals": 20}', '20d 00:00:00', 3760100);
    END IF;
    
    -- Level FC 7.2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 37) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 37, 'Embassy FC 7, Lancer Camp FC 7', '{"Meat": 130000000, "Wood": 130000000, "Coal": 26000000, "Iron": 6600000, "FireCrystals": 240, "RefinedFireCrystals": 20}', '20d 00:00:00', 3827700);
    END IF;
    
    -- Level FC 7.3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 38) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 38, 'Embassy FC 7, Lancer Camp FC 7', '{"Meat": 130000000, "Wood": 130000000, "Coal": 26000000, "Iron": 6600000, "FireCrystals": 240, "RefinedFireCrystals": 20}', '20d 00:00:00', 3895300);
    END IF;
    
    -- Level FC 7.4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 39) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 39, 'Embassy FC 7, Lancer Camp FC 7', '{"Meat": 130000000, "Wood": 130000000, "Coal": 26000000, "Iron": 6600000, "FireCrystals": 240, "RefinedFireCrystals": 20}', '20d 00:00:00', 3962900);
    END IF;
    
    -- Level FC 8
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 40) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 40, 'Embassy FC 7, Lancer Camp FC 7', '{"Meat": 130000000, "Wood": 130000000, "Coal": 26000000, "Iron": 6600000, "FireCrystals": 120, "RefinedFireCrystals": 40}', '20d 00:00:00', 4030500);
    END IF;
END $$;

-- Continue with FC 8.1 through FC 8.4 and FC 9
DO $$
BEGIN
    -- Level FC 8.1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 41) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 41, 'Embassy FC 8, Infantry Camp FC 8', '{"Meat": 140000000, "Wood": 140000000, "Coal": 29000000, "Iron": 7200000, "FireCrystals": 280, "RefinedFireCrystals": 30}', '13d 00:00:00', 4102900);
    END IF;
    
    -- Level FC 8.2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 42) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 42, 'Embassy FC 8, Infantry Camp FC 8', '{"Meat": 140000000, "Wood": 140000000, "Coal": 29000000, "Iron": 7200000, "FireCrystals": 280, "RefinedFireCrystals": 30}', '13d 00:00:00', 4175300);
    END IF;
    
    -- Level FC 8.3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 43) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 43, 'Embassy FC 8, Infantry Camp FC 8', '{"Meat": 140000000, "Wood": 140000000, "Coal": 29000000, "Iron": 7200000, "FireCrystals": 280, "RefinedFireCrystals": 30}', '13d 00:00:00', 4247700);
    END IF;
    
    -- Level FC 8.4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 44) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 44, 'Embassy FC 8, Infantry Camp FC 8', '{"Meat": 140000000, "Wood": 140000000, "Coal": 29000000, "Iron": 7200000, "FireCrystals": 280, "RefinedFireCrystals": 30}', '13d 00:00:00', 4320100);
    END IF;
    
    -- Level FC 9
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 45) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 45, 'Embassy FC 8, Infantry Camp FC 8', '{"Meat": 140000000, "Wood": 140000000, "Coal": 29000000, "Iron": 7200000, "FireCrystals": 140, "RefinedFireCrystals": 60}', '13d 00:00:00', 4392500);
    END IF;
END $$;

-- Final levels: FC 9.1 through FC 9.4 and FC 10
DO $$
BEGIN
    -- Level FC 9.1
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 46) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 46, 'Embassy FC 9, Marksman Camp FC 9', '{"Meat": 160000000, "Wood": 160000000, "Coal": 33000000, "Iron": 8400000, "FireCrystals": 350, "RefinedFireCrystals": 70}', '20d 00:00:00', 4464900);
    END IF;
    
    -- Level FC 9.2
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 47) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 47, 'Embassy FC 9, Marksman Camp FC 9', '{"Meat": 160000000, "Wood": 160000000, "Coal": 33000000, "Iron": 8400000, "FireCrystals": 350, "RefinedFireCrystals": 70}', '20d 00:00:00', 4537300);
    END IF;
    
    -- Level FC 9.3
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 48) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 48, 'Embassy FC 9, Marksman Camp FC 9', '{"Meat": 160000000, "Wood": 160000000, "Coal": 33000000, "Iron": 8400000, "FireCrystals": 350, "RefinedFireCrystals": 70}', '20d 00:00:00', 4609700);
    END IF;
    
    -- Level FC 9.4
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 49) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 49, 'Embassy FC 9, Marksman Camp FC 9', '{"Meat": 160000000, "Wood": 160000000, "Coal": 33000000, "Iron": 8400000, "FireCrystals": 350, "RefinedFireCrystals": 70}', '20d 00:00:00', 4682100);
    END IF;
    
    -- Level FC 10
    IF NOT EXISTS (SELECT 1 FROM building_levels WHERE building_name = 'Fire Crystal Furnace' AND level = 50) THEN
        INSERT INTO building_levels (building_name, level, prerequisites, build_cost, construction_time, building_power) 
        VALUES ('Fire Crystal Furnace', 50, 'Embassy FC 9, Marksman Camp FC 9', '{"Meat": 160000000, "Wood": 160000000, "Coal": 33000000, "Iron": 8400000, "FireCrystals": 175, "RefinedFireCrystals": 140}', '20d 00:00:00', 4754500);
    END IF;
END $$;

-- Fire Crystal Furnace migration completed with correct naming convention
-- All levels from 30-1 through FC 10 have been added with proper level_name field
-- Next: Add other Fire Crystal buildings (Embassy, Command Center, Camps) from CSV data
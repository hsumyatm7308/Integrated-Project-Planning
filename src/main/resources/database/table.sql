CREATE TABLE `users` (
  `userId` INT PRIMARY KEY AUTO_INCREMENT,
  `userName` VARCHAR(255),
  `userRole` ENUM ('manager', 'supervisor'),
  `userPhone` VARCHAR(255) UNIQUE,
  `userEmail` VARCHAR(255) UNIQUE,
  `userDOB` DATE,
  `userAddress` LONGTEXT,
  `userPassword` VARCHAR(255) NOT NULL,
  `userPhoto` VARCHAR(255),
  `userStartDate` DATE,
  `userEndDate` DATE DEFAULT null,
  `isActive` BOOLEAN DEFAULT true
);

CREATE TABLE `skills` (
  `skillId` INT PRIMARY KEY AUTO_INCREMENT,
  `skillName` VARCHAR(255)
);

CREATE TABLE `projectTypes` (
  `projectTypeId` INT PRIMARY KEY AUTO_INCREMENT,
  `typeName` VARCHAR(255)
);

CREATE TABLE `projectLevels` (
  `projectLevelId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectLevelName` VARCHAR(255)
);

CREATE TABLE `workItems` (
  `projectWorkItemId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectWorkItemName` VARCHAR(255)
);

CREATE TABLE `tasks` (
  `projectTaskId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectTaskName` VARCHAR(255)
);

CREATE TABLE `buildings` (
  `buildingId` INT PRIMARY KEY AUTO_INCREMENT,
  `buildingName` VARCHAR(255)
);

CREATE TABLE `proficiencyLevels` (
  `proficiencyLevelId` INT PRIMARY KEY AUTO_INCREMENT,
  `proficiencyLevelName` VARCHAR(255)
);

CREATE TABLE `labors` (
  `laborId` INT PRIMARY KEY AUTO_INCREMENT,
  `laborName` VARCHAR(255),
  `laborNRC` VARCHAR(255) UNIQUE NOT NULL,
  `laborPhone` VARCHAR(255),
  `skillId` INT,
  `laborStartDate` DATE,
  `laborEndDate` DATE,
  `proficiencyLevelId` INT,
  `yearsExperience` INT DEFAULT 1,
  `isActive` BOOLEAN DEFAULT true
);

CREATE TABLE `projectDetails` (
  `projectDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectTypeId` INT NOT NULL,
  `projectLevelId` INT,
  `projectBuildingId` INT,
  `minOverHeadCost` DOUBLE,
  `maxOverHeadCost` DOUBLE
);

CREATE TABLE `workItemDetails` (
  `workItemDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectDetailId` INT,
  `projectWorkItemId` INT NOT NULL,
  `minDuration` DOUBLE,
  `maxDuration` DOUBLE,
  `minLabors` DOUBLE,
  `maxLabors` DOUBLE,
  `minCost` DOUBLE,
  `maxCost` DOUBLE
);

CREATE TABLE `taskDetails` (
  `taskDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `workItemDetailId` INT,
  `projectTaskId` INT,
  `minDuration` DOUBLE,
  `maxDuration` DOUBLE,
  `quantityFormula` VARCHAR(255),
  `unitOfMeasure` VARCHAR(50)
);

CREATE TABLE `workItemRequireSkills` (
  `workItemRequireSkillId` INT PRIMARY KEY AUTO_INCREMENT,
  `workItemDetailId` INT,
  `skillId` INT,
  `minRequireLabors` DOUBLE,
  `maxRequireLabors` DOUBLE,
  `minDailyWage` DOUBLE,
  `maxDailyWage` DOUBLE
);

CREATE TABLE `assignStatus` (
  `assignStatusId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignStatusName` VARCHAR(255)
);

CREATE TABLE `projectStatus` (
  `projectStatusId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectStatusName` VARCHAR(255)
);

CREATE TABLE `assignProjects` (
  `assignProjectId` INT PRIMARY KEY AUTO_INCREMENT,
  `projectTypeId` INT,
  `projectInstanceName` VARCHAR(255),
  `projectLevelId` INT,
  `projectBuildingId` INT,
  `projectArea` DOUBLE,
  `projectHeight` DOUBLE DEFAULT 0,
  `totalStories` DOUBLE,
  `totalUnits` DOUBLE,
  `supervisorId` INT,
  `projectLocation` VARCHAR(255),
  `projectOverHeadCost` DOUBLE,
  `projectStatus` INT
);

CREATE TABLE `assignProjectDetails` (
  `assignProjectDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignProjectId` INT,
  `assignStatusId` INT,
  `projectCost` DOUBLE,
  `projectLaborQty` DOUBLE,
  `projectDuration` DOUBLE,
  `startDate` DATE,
  `endDate` DATE
);

CREATE TABLE `assignWorkItems` (
  `assignWorkItemId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignProjectId` INT,
  `projectWorkItemId` INT,
  `workItemStatus` INT
);

CREATE TABLE `assignWorkItemDetails` (
  `assignWorkItemDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignWorkItemId` INT,
  `assignStatusId` INT,
  `workItemCost` DOUBLE,
  `workItemLaborQty` DOUBLE,
  `workItemDuration` DOUBLE,
  `startDate` DATE,
  `endDate` DATE
);

CREATE TABLE `assignTasks` (
  `assignTaskId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignWorkItemId` INT,
  `projectTaskId` INT,
  `isCancel` BOOLEAN DEFAULT false,
  `taskStatus` INT,
  `plannedQty` DOUBLE NOT NULL,
  `unitOfMeasure` VARCHAR(50) NOT NULL
);

CREATE TABLE `assignTaskDetails` (
  `assignTaskDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignTaskId` INT,
  `assignStatusId` INT,
  `actualQty` DOUBLE,
  `startDate` DATE,
  `endDate` DATE
);

CREATE TABLE `assignWorkItemSkills` (
  `assignWorkItemSkillId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignWorkItemId` INT,
  `skillId` INT,
  `isCancel` BOOLEAN DEFAULT false
);

CREATE TABLE `assignWorkItemSkillDetails` (
  `assignWorkItemSkillDetailId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignWorkItemSkillId` INT,
  `assignStatusId` INT,
  `laborQty` DOUBLE,
  `dailyWagePerLabor` DOUBLE
);

CREATE TABLE `assignWorkers` (
  `assignWorkerId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignProjectId` INT,
  `workerId` INT,
  `isCancel` BOOLEAN DEFAULT false
);

CREATE TABLE `dailyReports` (
  `dailyReportId` INT PRIMARY KEY AUTO_INCREMENT,
  `assignProjectId` INT NOT NULL,
  `assignWorkItemId` INT NOT NULL,
  `reportDate` DATE NOT NULL,
  `supervisorId` INT,
  `weather` VARCHAR(100),
  `generalRemark` TEXT,
  `issue` LONGTEXT
);

CREATE TABLE `dailyReportTasks` (
  `dailyReportTaskId` INT PRIMARY KEY AUTO_INCREMENT,
  `dailyReportId` INT NOT NULL,
  `assignTaskId` INT NOT NULL,
  `actualQty` DOUBLE,
  `remark` TEXT
);

CREATE TABLE `dailyReportLabors` (
  `dailyReportLaborId` INT PRIMARY KEY AUTO_INCREMENT,
  `dailyReportId` INT NOT NULL,
  `laborId` INT NOT NULL,
  `laborQty` DOUBLE,
  `dailyWagePerLabor` DOUBLE,
  `remark` TEXT
);

CREATE INDEX `idx_labors_skillId` ON `labors` (`skillId`);

CREATE INDEX `idx_labors_proficiencyLevelId` ON `labors` (`proficiencyLevelId`);

CREATE INDEX `idx_projectDetails_type` ON `projectDetails` (`projectTypeId`);

CREATE INDEX `idx_projectDetails_level` ON `projectDetails` (`projectLevelId`);

CREATE INDEX `idx_projectDetails_building` ON `projectDetails` (`projectBuildingId`);

CREATE INDEX `idx_workItemDetails_projectDetailId` ON `workItemDetails` (`projectDetailId`);

CREATE INDEX `idx_workItemDetails_workItemId` ON `workItemDetails` (`projectWorkItemId`);

CREATE INDEX `idx_taskDetails_workItemDetailId` ON `taskDetails` (`workItemDetailId`);

CREATE INDEX `idx_taskDetails_taskId` ON `taskDetails` (`projectTaskId`);

CREATE INDEX `idx_workItemRequireSkills_workItemDetailId` ON `workItemRequireSkills` (`workItemDetailId`);

CREATE INDEX `idx_workItemRequireSkills_skillId` ON `workItemRequireSkills` (`skillId`);

CREATE INDEX `idx_assignProjects_projectTypeId` ON `assignProjects` (`projectTypeId`);

CREATE INDEX `idx_assignProjects_projectLevelId` ON `assignProjects` (`projectLevelId`);

CREATE INDEX `idx_assignProjects_projectBuildingId` ON `assignProjects` (`projectBuildingId`);

CREATE INDEX `idx_assignProjects_supervisorId` ON `assignProjects` (`supervisorId`);

CREATE INDEX `idx_assignProjects_projectStatus` ON `assignProjects` (`projectStatus`);

CREATE INDEX `idx_assignProjectDetails_assignProjectId` ON `assignProjectDetails` (`assignProjectId`);

CREATE INDEX `idx_assignProjectDetails_assignStatusId` ON `assignProjectDetails` (`assignStatusId`);

CREATE INDEX `idx_assignWorkItems_assignProjectId` ON `assignWorkItems` (`assignProjectId`);

CREATE INDEX `idx_assignWorkItems_projectWorkItemId` ON `assignWorkItems` (`projectWorkItemId`);

CREATE INDEX `idx_assignWorkItems_workItemStatus` ON `assignWorkItems` (`workItemStatus`);

CREATE INDEX `idx_assignWorkItemDetails_assignWorkItemId` ON `assignWorkItemDetails` (`assignWorkItemId`);

CREATE INDEX `idx_assignWorkItemDetails_assignStatusId` ON `assignWorkItemDetails` (`assignStatusId`);

CREATE INDEX `idx_assignTasks_assignWorkItemId` ON `assignTasks` (`assignWorkItemId`);

CREATE INDEX `idx_assignTasks_projectTaskId` ON `assignTasks` (`projectTaskId`);

CREATE INDEX `idx_assignTasks_taskStatus` ON `assignTasks` (`taskStatus`);

CREATE INDEX `idx_assignTaskDetails_assignTaskId` ON `assignTaskDetails` (`assignTaskId`);

CREATE INDEX `idx_assignTaskDetails_assignStatusId` ON `assignTaskDetails` (`assignStatusId`);

CREATE INDEX `idx_assignWorkItemSkills_assignWorkItemId` ON `assignWorkItemSkills` (`assignWorkItemId`);

CREATE INDEX `idx_assignWorkItemSkills_skillId` ON `assignWorkItemSkills` (`skillId`);

CREATE INDEX `idx_assignWorkItemSkillDetails_skillId` ON `assignWorkItemSkillDetails` (`assignWorkItemSkillId`);

CREATE INDEX `idx_assignWorkItemSkillDetails_statusId` ON `assignWorkItemSkillDetails` (`assignStatusId`);

CREATE INDEX `idx_assignWorkers_assignProjectId` ON `assignWorkers` (`assignProjectId`);

CREATE INDEX `idx_assignWorkers_workerId` ON `assignWorkers` (`workerId`);

CREATE UNIQUE INDEX `dailyReports_index_34` ON `dailyReports` (`assignProjectId`, `assignWorkItemId`, `reportDate`);

CREATE INDEX `idx_dailyReports_assignProjectId` ON `dailyReports` (`assignProjectId`);

CREATE INDEX `idx_dailyReports_assignWorkItemId` ON `dailyReports` (`assignWorkItemId`);

CREATE INDEX `idx_dailyReports_supervisorId` ON `dailyReports` (`supervisorId`);

CREATE INDEX `idx_dailyReportTasks_dailyReportId` ON `dailyReportTasks` (`dailyReportId`);

CREATE INDEX `idx_dailyReportTasks_assignTaskId` ON `dailyReportTasks` (`assignTaskId`);

CREATE INDEX `idx_dailyReportLabors_dailyReportId` ON `dailyReportLabors` (`dailyReportId`);

CREATE INDEX `idx_dailyReportLabors_laborId` ON `dailyReportLabors` (`laborId`);

ALTER TABLE `labors` ADD CONSTRAINT `fk_labors_skill` FOREIGN KEY (`skillId`) REFERENCES `skills` (`skillId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `labors` ADD CONSTRAINT `fk_labors_proficiency` FOREIGN KEY (`proficiencyLevelId`) REFERENCES `proficiencyLevels` (`proficiencyLevelId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `projectDetails` ADD CONSTRAINT `fk_projectDetails_type` FOREIGN KEY (`projectTypeId`) REFERENCES `projectTypes` (`projectTypeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `projectDetails` ADD CONSTRAINT `fk_projectDetails_level` FOREIGN KEY (`projectLevelId`) REFERENCES `projectLevels` (`projectLevelId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `projectDetails` ADD CONSTRAINT `fk_projectDetails_building` FOREIGN KEY (`projectBuildingId`) REFERENCES `buildings` (`buildingId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `workItemDetails` ADD CONSTRAINT `fk_workItemDetails_projectDetail` FOREIGN KEY (`projectDetailId`) REFERENCES `projectDetails` (`projectDetailId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `workItemDetails` ADD CONSTRAINT `fk_workItemDetails_workItem` FOREIGN KEY (`projectWorkItemId`) REFERENCES `workItems` (`projectWorkItemId`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `taskDetails` ADD CONSTRAINT `fk_taskDetails_workItemDetail` FOREIGN KEY (`workItemDetailId`) REFERENCES `workItemDetails` (`workItemDetailId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `taskDetails` ADD CONSTRAINT `fk_taskDetails_task` FOREIGN KEY (`projectTaskId`) REFERENCES `tasks` (`projectTaskId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `workItemRequireSkills` ADD CONSTRAINT `fk_workItemRequireSkills_workItemDetail` FOREIGN KEY (`workItemDetailId`) REFERENCES `workItemDetails` (`workItemDetailId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `workItemRequireSkills` ADD CONSTRAINT `fk_workItemRequireSkills_skill` FOREIGN KEY (`skillId`) REFERENCES `skills` (`skillId`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `assignProjects` ADD CONSTRAINT `fk_assignProjects_type` FOREIGN KEY (`projectTypeId`) REFERENCES `projectTypes` (`projectTypeId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `assignProjects` ADD CONSTRAINT `fk_assignProjects_level` FOREIGN KEY (`projectLevelId`) REFERENCES `projectLevels` (`projectLevelId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `assignProjects` ADD CONSTRAINT `fk_assignProjects_building` FOREIGN KEY (`projectBuildingId`) REFERENCES `buildings` (`buildingId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `assignProjects` ADD CONSTRAINT `fk_assignProjects_supervisor` FOREIGN KEY (`supervisorId`) REFERENCES `users` (`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `assignProjects` ADD CONSTRAINT `fk_assignProjects_status` FOREIGN KEY (`projectStatus`) REFERENCES `projectStatus` (`projectStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignProjectDetails` ADD CONSTRAINT `fk_assignProjectDetails_project` FOREIGN KEY (`assignProjectId`) REFERENCES `assignProjects` (`assignProjectId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignProjectDetails` ADD CONSTRAINT `fk_assignProjectDetails_status` FOREIGN KEY (`assignStatusId`) REFERENCES `assignStatus` (`assignStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItems` ADD CONSTRAINT `fk_assignWorkItems_project` FOREIGN KEY (`assignProjectId`) REFERENCES `assignProjects` (`assignProjectId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItems` ADD CONSTRAINT `fk_assignWorkItems_workItem` FOREIGN KEY (`projectWorkItemId`) REFERENCES `workItems` (`projectWorkItemId`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `assignWorkItems` ADD CONSTRAINT `fk_assignWorkItems_status` FOREIGN KEY (`workItemStatus`) REFERENCES `projectStatus` (`projectStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemDetails` ADD CONSTRAINT `fk_assignWorkItemDetails_workItem` FOREIGN KEY (`assignWorkItemId`) REFERENCES `assignWorkItems` (`assignWorkItemId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemDetails` ADD CONSTRAINT `fk_assignWorkItemDetails_status` FOREIGN KEY (`assignStatusId`) REFERENCES `assignStatus` (`assignStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignTasks` ADD CONSTRAINT `fk_assignTasks_workItem` FOREIGN KEY (`assignWorkItemId`) REFERENCES `assignWorkItems` (`assignWorkItemId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignTasks` ADD CONSTRAINT `fk_assignTasks_task` FOREIGN KEY (`projectTaskId`) REFERENCES `tasks` (`projectTaskId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `assignTasks` ADD CONSTRAINT `fk_assignTasks_status` FOREIGN KEY (`taskStatus`) REFERENCES `projectStatus` (`projectStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignTaskDetails` ADD CONSTRAINT `fk_assignTaskDetails_task` FOREIGN KEY (`assignTaskId`) REFERENCES `assignTasks` (`assignTaskId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignTaskDetails` ADD CONSTRAINT `fk_assignTaskDetails_status` FOREIGN KEY (`assignStatusId`) REFERENCES `assignStatus` (`assignStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemSkills` ADD CONSTRAINT `fk_assignWorkItemSkills_workItem` FOREIGN KEY (`assignWorkItemId`) REFERENCES `assignWorkItems` (`assignWorkItemId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemSkills` ADD CONSTRAINT `fk_assignWorkItemSkills_skill` FOREIGN KEY (`skillId`) REFERENCES `skills` (`skillId`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemSkillDetails` ADD CONSTRAINT `fk_assignWorkItemSkillDetails_status` FOREIGN KEY (`assignStatusId`) REFERENCES `assignStatus` (`assignStatusId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkItemSkillDetails` ADD CONSTRAINT `fk_assignWorkItemSkillDetails_skill` FOREIGN KEY (`assignWorkItemSkillId`) REFERENCES `assignWorkItemSkills` (`assignWorkItemSkillId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkers` ADD CONSTRAINT `fk_assignWorkers_project` FOREIGN KEY (`assignProjectId`) REFERENCES `assignProjects` (`assignProjectId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `assignWorkers` ADD CONSTRAINT `fk_assignWorkers_worker` FOREIGN KEY (`workerId`) REFERENCES `labors` (`laborId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReports` ADD CONSTRAINT `fk_dailyReports_project` FOREIGN KEY (`assignProjectId`) REFERENCES `assignProjects` (`assignProjectId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReports` ADD CONSTRAINT `fk_dailyReports_supervisor` FOREIGN KEY (`supervisorId`) REFERENCES `users` (`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `dailyReports` ADD CONSTRAINT `fk_dailyReports_workItem` FOREIGN KEY (`assignWorkItemId`) REFERENCES `assignWorkItems` (`assignWorkItemId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReportTasks` ADD CONSTRAINT `fk_dailyReportTasks_report` FOREIGN KEY (`dailyReportId`) REFERENCES `dailyReports` (`dailyReportId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReportTasks` ADD CONSTRAINT `fk_dailyReportTasks_task` FOREIGN KEY (`assignTaskId`) REFERENCES `assignTasks` (`assignTaskId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReportLabors` ADD CONSTRAINT `fk_dailyReportLabors_report` FOREIGN KEY (`dailyReportId`) REFERENCES `dailyReports` (`dailyReportId`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dailyReportLabors` ADD CONSTRAINT `fk_dailyReportLabors_labor` FOREIGN KEY (`laborId`) REFERENCES `labors` (`laborId`) ON DELETE CASCADE ON UPDATE CASCADE;

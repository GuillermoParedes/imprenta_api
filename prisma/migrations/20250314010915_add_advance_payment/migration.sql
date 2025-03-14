/*
  Warnings:

  - You are about to drop the `OrderItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userRole` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `advancePayment` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `OrderItem` DROP FOREIGN KEY `OrderItem_orderId_fkey`;

-- DropForeignKey
ALTER TABLE `OrderItem` DROP FOREIGN KEY `OrderItem_productId_fkey`;

-- DropForeignKey
ALTER TABLE `userRole` DROP FOREIGN KEY `userRole_roleId_fkey`;

-- DropForeignKey
ALTER TABLE `userRole` DROP FOREIGN KEY `userRole_userId_fkey`;

-- AlterTable
ALTER TABLE `Order` ADD COLUMN `advancePayment` DOUBLE NOT NULL;

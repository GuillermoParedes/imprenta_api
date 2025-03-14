-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `first_name` VARCHAR(191) NOT NULL,
    `last_name` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `codeExpireAt` DATETIME(3) NULL,
    `role` ENUM('ADMINISTRADOR', 'VENDEDOR') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(25) NOT NULL,
    `descripcion` VARCHAR(250) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userRole` (
    `id` VARCHAR(191) NOT NULL,
    `roleId` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Client` (
    `id` VARCHAR(191) NOT NULL,
    `first_name` VARCHAR(191) NOT NULL,
    `last_name` VARCHAR(191) NOT NULL,
    `type` ENUM('NATURAL', 'JURIDICA') NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `cellphone` VARCHAR(191) NOT NULL,
    `ranking` ENUM('BUENO', 'MALO') NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `id` VARCHAR(191) NOT NULL,
    `customerId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `totalAmount` DOUBLE NOT NULL,
    `quantity` INTEGER NOT NULL,
    `dateShipping` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `status` ENUM('PENDIENTE', 'ENTREGADO', 'CANCELADO') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Product` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `sellingPrice` DOUBLE NOT NULL,
    `actualPrice` DOUBLE NOT NULL,
    `stock` INTEGER NOT NULL,
    `categoryId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Category` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `userRole` ADD CONSTRAINT `userRole_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `Role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userRole` ADD CONSTRAINT `userRole_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_customerId_fkey` FOREIGN KEY (`customerId`) REFERENCES `Client`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;


-- Adminer 4.8.1 MySQL 11.6.2-MariaDB-ubu2404 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

INSERT INTO `Category` (`id`, `name`, `description`, `createdAt`, `updatedAt`) VALUES
('Folletos',	'Folletos',	'Impresion de folletos',	'2024-10-27 21:20:20.000',	'2024-10-27 21:20:20.000'),
('Invitaciones',	'Invitaciones',	'Invitaciones personalizadas para sus eventos',	'2024-10-27 21:20:35.000',	'2024-10-27 21:20:35.000'),
('Libros',	'Libros',	'Impresion de libros',	'2024-10-27 21:20:08.000',	'2024-10-27 21:20:08.000'),
('Otros',	'Otros',	'Otro producto grafico',	'2024-10-27 21:22:28.000',	'2024-10-27 21:22:28.000'),
('TarjetasPersonales',	'Tarjetas Personales',	'Tarjetas Personales para tu negocio',	'2024-10-27 21:21:00.000',	'2024-10-27 21:21:00.000');

INSERT INTO `Client` (`id`, `first_name`, `last_name`, `type`, `address`, `cellphone`, `ranking`, `createdAt`, `updatedAt`) VALUES
('client_104357',	'CRE R.L.',	'',	'JURIDICA',	'Calle 424 Zona Este',	'+591 74887721',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_115505',	'Carmen',	'Vargas',	'NATURAL',	'Calle 516 Zona Oeste',	'+591 78599043',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_118121',	'Daniela',	'Medina',	'NATURAL',	'Calle 395 Zona Central',	'+591 61608908',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_124153',	'Valeria',	'Ramírez',	'NATURAL',	'Calle 583 Zona Norte',	'+591 69243949',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_126035',	'Soboce S.A.',	'',	'JURIDICA',	'Calle 795 Zona Oeste',	'+591 64132257',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_132065',	'CRE R.L.',	'',	'JURIDICA',	'Calle 746 Zona Este',	'+591 69152383',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_138257',	'Banco Bisa S.A.',	'',	'JURIDICA',	'Calle 963 Zona Este',	'+591 67497110',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_168035',	'María',	'Ramírez',	'NATURAL',	'Calle 947 Zona Central',	'+591 69764481',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_178266',	'Hugo',	'Ortega',	'NATURAL',	'Calle 710 Zona Central',	'+591 65006747',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_206366',	'Jorge',	'Fernández',	'NATURAL',	'Calle 628 Zona Norte',	'+591 64741112',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_281252',	'Gabriela',	'Herrera',	'NATURAL',	'Calle 91 Zona Norte',	'+591 67177308',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_335759',	'La Papelera S.A.',	'',	'JURIDICA',	'Calle 194 Zona Oeste',	'+591 64427261',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_407822',	'Carmen',	'Chávez',	'NATURAL',	'Calle 110 Zona Norte',	'+591 67770384',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_474106',	'CRE R.L.',	'',	'JURIDICA',	'Calle 237 Zona Sur',	'+591 71281975',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_487938',	'Daniela',	'Navarro',	'NATURAL',	'Calle 186 Zona Sur',	'+591 60931470',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_497316',	'Ana',	'Ortega',	'NATURAL',	'Calle 526 Zona Oeste',	'+591 65628295',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_506721',	'Sofía',	'González',	'NATURAL',	'Calle 711 Zona Este',	'+591 73742823',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_563434',	'Soboce S.A.',	'',	'JURIDICA',	'Calle 387 Zona Norte',	'+591 73873962',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_577895',	'Sofía',	'Chávez',	'NATURAL',	'Calle 740 Zona Oeste',	'+591 61836078',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_598304',	'Banco Unión S.A.',	'',	'JURIDICA',	'Calle 12 Zona Norte',	'+591 69312522',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_661159',	'Banco Mercantil Santa Cruz',	'',	'JURIDICA',	'Calle 125 Zona Central',	'+591 67081716',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_675386',	'Empresa Nacional de Telecomunicaciones (ENTEL)',	'',	'JURIDICA',	'Calle 867 Zona Oeste',	'+591 62175325',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_698153',	'Empresa Nacional de Telecomunicaciones (ENTEL)',	'',	'JURIDICA',	'Calle 109 Zona Sur',	'+591 75512746',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_698297',	'Patricia',	'Suárez',	'NATURAL',	'Calle 473 Zona Oeste',	'+591 68476939',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_707741',	'Hansa Ltda.',	'',	'JURIDICA',	'Calle 111 Zona Este',	'+591 66036921',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_719768',	'Banco Nacional de Bolivia',	'',	'JURIDICA',	'Calle 996 Zona Central',	'+591 72239273',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_720180',	'Banco Unión S.A.',	'',	'JURIDICA',	'Calle 521 Zona Norte',	'+591 76442423',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_724504',	'Diego',	'Herrera',	'NATURAL',	'Calle 104 Zona Oeste',	'+591 64338877',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_728441',	'Boliviana de Aviación',	'',	'JURIDICA',	'Calle 302 Zona Oeste',	'+591 73890814',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_738662',	'Laboratorios INTI',	'',	'JURIDICA',	'Calle 886 Zona Norte',	'+591 74992020',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_747650',	'PIL Andina S.A.',	'',	'JURIDICA',	'Calle 786 Zona Norte',	'+591 78323605',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_748680',	'CRE R.L.',	'',	'JURIDICA',	'Calle 421 Zona Este',	'+591 60345013',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_775454',	'María',	'Navarro',	'NATURAL',	'Calle 471 Zona Oeste',	'+591 61228643',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_781927',	'La Papelera S.A.',	'',	'JURIDICA',	'Calle 348 Zona Norte',	'+591 76854307',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_784461',	'Cervecería Boliviana Nacional',	'',	'JURIDICA',	'Calle 876 Zona Oeste',	'+591 65505563',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_790685',	'Carlos',	'Sánchez',	'NATURAL',	'Calle 138 Zona Norte',	'+591 79471585',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_824398',	'Banco Bisa S.A.',	'',	'JURIDICA',	'Calle 47 Zona Sur',	'+591 61627605',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_834254',	'Soboce S.A.',	'',	'JURIDICA',	'Calle 450 Zona Este',	'+591 79387821',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_846358',	'Empresa Nacional de Telecomunicaciones (ENTEL)',	'',	'JURIDICA',	'Calle 87 Zona Sur',	'+591 63764226',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_849349',	'Sofía',	'Suárez',	'NATURAL',	'Calle 464 Zona Central',	'+591 64040451',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_850656',	'Boliviana de Aviación',	'',	'JURIDICA',	'Calle 520 Zona Oeste',	'+591 68784806',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_858131',	'Patricia',	'Sánchez',	'NATURAL',	'Calle 894 Zona Sur',	'+591 64012756',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_919769',	'YPFB Corporación',	'',	'JURIDICA',	'Calle 539 Zona Norte',	'+591 67830380',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_936742',	'Valeria',	'Pérez',	'NATURAL',	'Calle 388 Zona Sur',	'+591 79355948',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_942064',	'Laboratorios INTI',	'',	'JURIDICA',	'Calle 837 Zona Central',	'+591 68969404',	NULL,	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_945368',	'Banco Mercantil Santa Cruz',	'',	'JURIDICA',	'Calle 814 Zona Este',	'+591 62596683',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_948050',	'Empresa Nacional de Telecomunicaciones (ENTEL)',	'',	'JURIDICA',	'Calle 763 Zona Este',	'+591 62070686',	'BUENO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000'),
('client_981776',	'PIL Andina S.A.',	'',	'JURIDICA',	'Calle 712 Zona Oeste',	'+591 78968991',	'MALO',	'2025-02-25 23:17:13.000',	'2025-02-25 23:17:13.000');


INSERT INTO `Product` (`id`, `name`, `description`, `sellingPrice`, `actualPrice`, `stock`, `categoryId`, `createdAt`, `updatedAt`) VALUES
('prod_103889',	'Libros 83',	'Descripción de libros',	60.56,	75.99,	377,	'libros',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_105991',	'Libros 24',	'Descripción de libros',	22.6,	33,	196,	'libros',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_107318',	'Otros 95',	'Descripción de otros',	12.94,	7.84,	404,	'otros',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_109988',	'Invitaciones 47',	'Descripción de invitaciones',	80.77,	76.98,	479,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_118214',	'Invitaciones 97',	'Descripción de invitaciones',	38.89,	39.63,	67,	'Invitaciones',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_120694',	'Tarjetas Personales 64',	'Descripción de tarjetas personales',	58.63,	81.2,	448,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_131108',	'Libros 67',	'Descripción de libros',	23.1,	29.37,	54,	'libros',	'2024-12-07 00:00:00.000',	'2024-12-07 00:00:00.000'),
('prod_132263',	'Otros 84',	'Descripción de otros',	50.78,	57.5,	396,	'otros',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_144568',	'Libros 91',	'Descripción de libros',	84.68,	66.53,	224,	'libros',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_147195',	'Invitaciones 89',	'Descripción de invitaciones',	36.81,	37.07,	52,	'Invitaciones',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_150053',	'Folletos 22',	'Descripción de folletos',	38.97,	55.06,	149,	'Folletos',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_150285',	'Libros 9',	'Descripción de libros',	12.25,	49.71,	137,	'libros',	'2024-11-03 00:00:00.000',	'2024-11-03 00:00:00.000'),
('prod_155802',	'Libros 64',	'Descripción de libros',	17.93,	42.1,	35,	'libros',	'2025-02-21 00:00:00.000',	'2025-02-21 00:00:00.000'),
('prod_172148',	'Folletos 7',	'Descripción de folletos',	73.54,	25.08,	216,	'Folletos',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_185452',	'Folletos 81',	'Descripción de folletos',	94.22,	31.92,	183,	'Folletos',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_186279',	'Otros 26',	'Descripción de otros',	10.84,	68.62,	216,	'otros',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_190557',	'Tarjetas Personales 94',	'Descripción de tarjetas personales',	73.75,	65.1,	93,	'TarjetasPersonales',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_194716',	'Otros 1',	'Descripción de otros',	44.86,	66.27,	190,	'otros',	'2024-10-20 00:00:00.000',	'2024-10-20 00:00:00.000'),
('prod_194993',	'Invitaciones 22',	'Descripción de invitaciones',	81.27,	66.53,	196,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_195654',	'Otros 23',	'Descripción de otros',	14.19,	29.16,	209,	'otros',	'2024-10-04 00:00:00.000',	'2024-10-04 00:00:00.000'),
('prod_204669',	'Otros 54',	'Descripción de otros',	93.25,	33.35,	113,	'otros',	'2025-02-23 00:00:00.000',	'2025-02-23 00:00:00.000'),
('prod_210926',	'Otros 33',	'Descripción de otros',	17.71,	37.43,	288,	'otros',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_215607',	'Folletos 73',	'Descripción de folletos',	40.1,	78.75,	50,	'Folletos',	'2024-12-07 00:00:00.000',	'2024-12-07 00:00:00.000'),
('prod_218985',	'Folletos 64',	'Descripción de folletos',	27.32,	66.91,	85,	'Folletos',	'2025-01-02 00:00:00.000',	'2025-01-02 00:00:00.000'),
('prod_219221',	'Folletos 87',	'Descripción de folletos',	44.2,	26.43,	493,	'Folletos',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_221770',	'Tarjetas Personales 73',	'Descripción de tarjetas personales',	7.92,	2.21,	405,	'TarjetasPersonales',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_233769',	'Folletos 59',	'Descripción de folletos',	81.99,	14.7,	129,	'Folletos',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_237228',	'Tarjetas Personales 43',	'Descripción de tarjetas personales',	65.88,	31.91,	397,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_237644',	'Otros 26',	'Descripción de otros',	68.88,	8.1,	77,	'otros',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_238737',	'Libros 67',	'Descripción de libros',	45.88,	15.39,	360,	'libros',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_252797',	'Tarjetas Personales 86',	'Descripción de tarjetas personales',	77.87,	48.26,	440,	'TarjetasPersonales',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_255788',	'Tarjetas Personales 5',	'Descripción de tarjetas personales',	78.61,	28.75,	32,	'TarjetasPersonales',	'2025-02-21 00:00:00.000',	'2025-02-21 00:00:00.000'),
('prod_262844',	'Otros 53',	'Descripción de otros',	38.53,	15.9,	115,	'otros',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_266643',	'Invitaciones 29',	'Descripción de invitaciones',	86.62,	7.96,	46,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_268222',	'Otros 18',	'Descripción de otros',	18.86,	77.75,	461,	'otros',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_271053',	'Libros 75',	'Descripción de libros',	11.09,	34.24,	265,	'libros',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_272345',	'Invitaciones 36',	'Descripción de invitaciones',	39.98,	61.78,	296,	'Invitaciones',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_277891',	'Invitaciones 24',	'Descripción de invitaciones',	78.16,	32.28,	6,	'Invitaciones',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_282015',	'Libros 21',	'Descripción de libros',	73.01,	59.5,	274,	'libros',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_287221',	'Invitaciones 70',	'Descripción de invitaciones',	69.88,	29.4,	372,	'Invitaciones',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_290264',	'Libros 73',	'Descripción de libros',	35.46,	67.63,	415,	'libros',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_292158',	'Libros 27',	'Descripción de libros',	99.15,	69.91,	30,	'libros',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_294258',	'Invitaciones 54',	'Descripción de invitaciones',	46.25,	66.57,	440,	'Invitaciones',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_322728',	'Tarjetas Personales 22',	'Descripción de tarjetas personales',	31.41,	45.25,	220,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_324883',	'Folletos 13',	'Descripción de folletos',	7.68,	72.21,	292,	'Folletos',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_330551',	'Folletos 61',	'Descripción de folletos',	14.21,	28.8,	319,	'Folletos',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_331488',	'Otros 24',	'Descripción de otros',	79.52,	52.43,	184,	'otros',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_332689',	'Tarjetas Personales 86',	'Descripción de tarjetas personales',	96.14,	9.76,	289,	'TarjetasPersonales',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_334383',	'Tarjetas Personales 27',	'Descripción de tarjetas personales',	86.24,	31.89,	274,	'TarjetasPersonales',	'2024-10-04 00:00:00.000',	'2024-10-04 00:00:00.000'),
('prod_335031',	'Otros 15',	'Descripción de otros',	77.57,	1.75,	478,	'otros',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_341027',	'Invitaciones 19',	'Descripción de invitaciones',	30.07,	27.72,	472,	'Invitaciones',	'2024-11-10 00:00:00.000',	'2024-11-10 00:00:00.000'),
('prod_345714',	'Invitaciones 96',	'Descripción de invitaciones',	85.85,	6.31,	301,	'Invitaciones',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_362458',	'Folletos 96',	'Descripción de folletos',	65.34,	66.14,	161,	'Folletos',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_371032',	'Libros 77',	'Descripción de libros',	21.26,	23.44,	104,	'libros',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_371986',	'Invitaciones 100',	'Descripción de invitaciones',	66.28,	19.89,	496,	'Invitaciones',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_374655',	'Folletos 36',	'Descripción de folletos',	30.03,	38.92,	396,	'Folletos',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_392580',	'Invitaciones 41',	'Descripción de invitaciones',	38.88,	76.1,	433,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_395314',	'Tarjetas Personales 87',	'Descripción de tarjetas personales',	69.47,	6.64,	120,	'TarjetasPersonales',	'2024-11-03 00:00:00.000',	'2024-11-03 00:00:00.000'),
('prod_398975',	'Tarjetas Personales 10',	'Descripción de tarjetas personales',	7.21,	21.75,	428,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_405759',	'Invitaciones 73',	'Descripción de invitaciones',	14.25,	77.83,	145,	'Invitaciones',	'2024-10-20 00:00:00.000',	'2024-10-20 00:00:00.000'),
('prod_408308',	'Libros 83',	'Descripción de libros',	91.21,	43.58,	373,	'libros',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_409411',	'Folletos 12',	'Descripción de folletos',	28.36,	67.62,	266,	'Folletos',	'2025-02-10 00:00:00.000',	'2025-02-10 00:00:00.000'),
('prod_410114',	'Invitaciones 28',	'Descripción de invitaciones',	79.93,	69.51,	328,	'Invitaciones',	'2024-11-03 00:00:00.000',	'2024-11-03 00:00:00.000'),
('prod_422702',	'Otros 51',	'Descripción de otros',	69.33,	40.62,	434,	'otros',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_423411',	'Invitaciones 91',	'Descripción de invitaciones',	94.63,	14.64,	348,	'Invitaciones',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_431808',	'Invitaciones 23',	'Descripción de invitaciones',	52.06,	34.03,	416,	'Invitaciones',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_436684',	'Otros 20',	'Descripción de otros',	61.49,	79.37,	382,	'otros',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_442816',	'Folletos 35',	'Descripción de folletos',	56.41,	23.49,	302,	'Folletos',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_443022',	'Invitaciones 85',	'Descripción de invitaciones',	43.73,	66.68,	494,	'Invitaciones',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_448948',	'Libros 93',	'Descripción de libros',	99.07,	54.01,	222,	'libros',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_453150',	'Libros 25',	'Descripción de libros',	29.5,	48.34,	32,	'libros',	'2024-11-13 00:00:00.000',	'2024-11-13 00:00:00.000'),
('prod_454082',	'Libros 94',	'Descripción de libros',	50.57,	50.78,	270,	'libros',	'2025-02-23 00:00:00.000',	'2025-02-23 00:00:00.000'),
('prod_461351',	'Otros 86',	'Descripción de otros',	8.71,	55.92,	48,	'otros',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_467668',	'Folletos 54',	'Descripción de folletos',	48.57,	86.05,	6,	'Folletos',	'2025-02-21 00:00:00.000',	'2025-02-21 00:00:00.000'),
('prod_469488',	'Otros 73',	'Descripción de otros',	98.18,	33.76,	399,	'otros',	'2024-11-03 00:00:00.000',	'2024-11-03 00:00:00.000'),
('prod_470115',	'Tarjetas Personales 94',	'Descripción de tarjetas personales',	30.57,	56.95,	72,	'TarjetasPersonales',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_471883',	'Tarjetas Personales 85',	'Descripción de tarjetas personales',	49.65,	82.62,	259,	'TarjetasPersonales',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_473940',	'Folletos 32',	'Descripción de folletos',	77.11,	31.42,	2,	'Folletos',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_474743',	'Libros 59',	'Descripción de libros',	64.8,	5,	150,	'libros',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_482228',	'Otros 7',	'Descripción de otros',	98.28,	10.83,	297,	'otros',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_495483',	'Invitaciones 17',	'Descripción de invitaciones',	99.2,	26.21,	112,	'Invitaciones',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_506206',	'Folletos 23',	'Descripción de folletos',	89.43,	16.28,	443,	'Folletos',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_506536',	'Folletos 21',	'Descripción de folletos',	7.88,	60.76,	446,	'Folletos',	'2024-12-07 00:00:00.000',	'2024-12-07 00:00:00.000'),
('prod_508864',	'Tarjetas Personales 21',	'Descripción de tarjetas personales',	97.38,	29.05,	210,	'TarjetasPersonales',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_510065',	'Libros 33',	'Descripción de libros',	26.9,	67.78,	446,	'libros',	'2024-10-20 00:00:00.000',	'2024-10-20 00:00:00.000'),
('prod_510724',	'Otros 33',	'Descripción de otros',	50.95,	5.78,	155,	'otros',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_514701',	'Folletos 55',	'Descripción de folletos',	74.82,	17.93,	64,	'Folletos',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_515655',	'Tarjetas Personales 58',	'Descripción de tarjetas personales',	21.23,	1.86,	326,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_522953',	'Folletos 27',	'Descripción de folletos',	87.38,	63.78,	300,	'Folletos',	'2024-11-26 00:00:00.000',	'2024-11-26 00:00:00.000'),
('prod_524409',	'Otros 23',	'Descripción de otros',	76.37,	20.43,	224,	'otros',	'2024-11-26 00:00:00.000',	'2024-11-26 00:00:00.000'),
('prod_527886',	'Otros 43',	'Descripción de otros',	93.94,	61.52,	9,	'otros',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_528560',	'Otros 46',	'Descripción de otros',	70.5,	15.29,	180,	'otros',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_530238',	'Otros 81',	'Descripción de otros',	29.2,	72.24,	154,	'otros',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_541626',	'Folletos 47',	'Descripción de folletos',	40.04,	51.19,	141,	'Folletos',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_541887',	'Tarjetas Personales 53',	'Descripción de tarjetas personales',	90.03,	64.94,	112,	'TarjetasPersonales',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_545069',	'Otros 55',	'Descripción de otros',	64.31,	51.91,	246,	'otros',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_554378',	'Otros 1',	'Descripción de otros',	85.7,	31.23,	427,	'otros',	'2024-12-07 00:00:00.000',	'2024-12-07 00:00:00.000'),
('prod_555167',	'Folletos 36',	'Descripción de folletos',	14.48,	83.89,	230,	'Folletos',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_557466',	'Otros 59',	'Descripción de otros',	19.16,	39.15,	475,	'otros',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_559171',	'Libros 67',	'Descripción de libros',	51.72,	59.34,	367,	'libros',	'2024-12-07 00:00:00.000',	'2024-12-07 00:00:00.000'),
('prod_560592',	'Invitaciones 19',	'Descripción de invitaciones',	81.71,	34.43,	479,	'Invitaciones',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_561354',	'Libros 49',	'Descripción de libros',	53.46,	45.3,	404,	'libros',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_563055',	'Otros 22',	'Descripción de otros',	76.79,	59.69,	59,	'otros',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_566176',	'Otros 2',	'Descripción de otros',	19.1,	22.26,	17,	'otros',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_573705',	'Tarjetas Personales 21',	'Descripción de tarjetas personales',	17.87,	46.36,	406,	'TarjetasPersonales',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_575652',	'Otros 87',	'Descripción de otros',	53.28,	52.28,	39,	'otros',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_576450',	'Libros 50',	'Descripción de libros',	82.88,	75.47,	147,	'libros',	'2024-11-03 00:00:00.000',	'2024-11-03 00:00:00.000'),
('prod_593670',	'Invitaciones 62',	'Descripción de invitaciones',	84.29,	47.38,	236,	'Invitaciones',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_604548',	'Otros 64',	'Descripción de otros',	99.55,	86.86,	293,	'otros',	'2024-10-04 00:00:00.000',	'2024-10-04 00:00:00.000'),
('prod_608085',	'Otros 76',	'Descripción de otros',	59.77,	24.6,	115,	'otros',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_618056',	'Tarjetas Personales 79',	'Descripción de tarjetas personales',	7.57,	73.21,	306,	'TarjetasPersonales',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_624239',	'Invitaciones 15',	'Descripción de invitaciones',	81.19,	37.55,	96,	'Invitaciones',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_637567',	'Folletos 82',	'Descripción de folletos',	33.33,	1.4,	36,	'Folletos',	'2024-11-13 00:00:00.000',	'2024-11-13 00:00:00.000'),
('prod_637939',	'Invitaciones 57',	'Descripción de invitaciones',	25.92,	62.39,	122,	'Invitaciones',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_638512',	'Otros 76',	'Descripción de otros',	24.82,	84.25,	450,	'otros',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_641775',	'Invitaciones 17',	'Descripción de invitaciones',	22.09,	10.06,	86,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_654167',	'Folletos 32',	'Descripción de folletos',	12.8,	5.86,	393,	'Folletos',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_658646',	'Libros 83',	'Descripción de libros',	83.66,	87,	202,	'libros',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_667807',	'Invitaciones 46',	'Descripción de invitaciones',	81.3,	72.95,	182,	'Invitaciones',	'2025-02-21 00:00:00.000',	'2025-02-21 00:00:00.000'),
('prod_678177',	'Otros 66',	'Descripción de otros',	59.15,	58.16,	164,	'otros',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_686585',	'Invitaciones 65',	'Descripción de invitaciones',	29.62,	33.87,	206,	'Invitaciones',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_690925',	'Folletos 80',	'Descripción de folletos',	81.31,	68.96,	256,	'Folletos',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_695585',	'Invitaciones 30',	'Descripción de invitaciones',	35.07,	85.53,	445,	'Invitaciones',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_697549',	'Libros 18',	'Descripción de libros',	7.68,	78.25,	195,	'libros',	'2024-10-04 00:00:00.000',	'2024-10-04 00:00:00.000'),
('prod_706158',	'Folletos 56',	'Descripción de folletos',	75.95,	67.04,	404,	'Folletos',	'2025-02-23 00:00:00.000',	'2025-02-23 00:00:00.000'),
('prod_706788',	'Libros 59',	'Descripción de libros',	55.11,	31.68,	297,	'libros',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_707432',	'Folletos 42',	'Descripción de folletos',	60.53,	82.31,	415,	'Folletos',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_712145',	'Libros 28',	'Descripción de libros',	96.39,	51.07,	314,	'libros',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_714560',	'Folletos 89',	'Descripción de folletos',	62.46,	34.56,	406,	'Folletos',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_714888',	'Invitaciones 24',	'Descripción de invitaciones',	83.84,	86.32,	385,	'Invitaciones',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_715857',	'Invitaciones 56',	'Descripción de invitaciones',	22.84,	35.9,	39,	'Invitaciones',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_721071',	'Tarjetas Personales 98',	'Descripción de tarjetas personales',	33.47,	42.13,	98,	'TarjetasPersonales',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_721675',	'Otros 25',	'Descripción de otros',	55.57,	62.42,	334,	'otros',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_725000',	'Libros 21',	'Descripción de libros',	79.83,	85.7,	496,	'libros',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_728683',	'Otros 30',	'Descripción de otros',	46.74,	8.57,	50,	'otros',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_733819',	'Folletos 95',	'Descripción de folletos',	35.95,	53.01,	334,	'Folletos',	'2025-02-21 00:00:00.000',	'2025-02-21 00:00:00.000'),
('prod_740744',	'Invitaciones 95',	'Descripción de invitaciones',	91.03,	83.89,	215,	'Invitaciones',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_741054',	'Tarjetas Personales 90',	'Descripción de tarjetas personales',	66,	42.31,	381,	'TarjetasPersonales',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_742405',	'Invitaciones 20',	'Descripción de invitaciones',	15.58,	41.19,	64,	'Invitaciones',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_745153',	'Libros 25',	'Descripción de libros',	15.06,	44.23,	88,	'libros',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_750559',	'Invitaciones 95',	'Descripción de invitaciones',	52.77,	68.24,	349,	'Invitaciones',	'2025-01-02 00:00:00.000',	'2025-01-02 00:00:00.000'),
('prod_753418',	'Invitaciones 51',	'Descripción de invitaciones',	48.47,	20.24,	78,	'Invitaciones',	'2025-02-23 00:00:00.000',	'2025-02-23 00:00:00.000'),
('prod_757157',	'Otros 78',	'Descripción de otros',	56.1,	81.27,	295,	'Otros',	'2024-11-10 00:00:00.000',	'2024-11-10 00:00:00.000'),
('prod_762337',	'Tarjetas Personales 57',	'Descripción de tarjetas personales',	44.87,	17.07,	181,	'TarjetasPersonales',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_770298',	'Invitaciones 18',	'Descripción de invitaciones',	65.45,	40.2,	278,	'Invitaciones',	'2025-02-10 00:00:00.000',	'2025-02-10 00:00:00.000'),
('prod_773010',	'Tarjetas Personales 6',	'Descripción de tarjetas personales',	69.4,	63.87,	409,	'TarjetasPersonales',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_773042',	'Libros 2',	'Descripción de libros',	9.72,	38.33,	22,	'libros',	'2025-02-23 00:00:00.000',	'2025-02-23 00:00:00.000'),
('prod_776953',	'Folletos 82',	'Descripción de folletos',	21.12,	31.8,	220,	'Folletos',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_777213',	'Tarjetas Personales 10',	'Descripción de tarjetas personales',	98.99,	36.75,	242,	'TarjetasPersonales',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_781423',	'Folletos 95',	'Descripción de folletos',	24.25,	83.66,	476,	'Folletos',	'2025-02-14 00:00:00.000',	'2025-02-14 00:00:00.000'),
('prod_789909',	'Folletos 57',	'Descripción de folletos',	51.06,	44.77,	469,	'Folletos',	'2025-01-02 00:00:00.000',	'2025-01-02 00:00:00.000'),
('prod_790596',	'Tarjetas Personales 26',	'Descripción de tarjetas personales',	82.69,	47.12,	309,	'TarjetasPersonales',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_793151',	'Folletos 34',	'Descripción de folletos',	22.76,	86.81,	315,	'Folletos',	'2024-11-26 00:00:00.000',	'2024-11-26 00:00:00.000'),
('prod_793357',	'Invitaciones 62',	'Descripción de invitaciones',	73,	10.55,	97,	'Invitaciones',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_797827',	'Tarjetas Personales 4',	'Descripción de tarjetas personales',	83.92,	88.68,	170,	'TarjetasPersonales',	'2024-09-22 00:00:00.000',	'2024-09-22 00:00:00.000'),
('prod_800558',	'Otros 72',	'Descripción de otros',	17.75,	52.01,	251,	'otros',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_802589',	'Tarjetas Personales 20',	'Descripción de tarjetas personales',	12.47,	59.29,	324,	'TarjetasPersonales',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_823553',	'Libros 53',	'Descripción de libros',	25.47,	40.07,	11,	'libros',	'2024-10-01 00:00:00.000',	'2024-10-01 00:00:00.000'),
('prod_823814',	'Invitaciones 49',	'Descripción de invitaciones',	79.34,	89.65,	14,	'Invitaciones',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_825566',	'Folletos 26',	'Descripción de folletos',	71.76,	37.11,	299,	'Folletos',	'2024-09-22 00:00:00.000',	'2024-09-22 00:00:00.000'),
('prod_826574',	'Libros 95',	'Descripción de libros',	47.16,	85.26,	310,	'libros',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_829355',	'Folletos 55',	'Descripción de folletos',	10.68,	32.38,	281,	'Folletos',	'2024-11-24 00:00:00.000',	'2024-11-24 00:00:00.000'),
('prod_831311',	'Libros 31',	'Descripción de libros',	82.54,	42.8,	58,	'libros',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_831429',	'Folletos 63',	'Descripción de folletos',	32.2,	79.6,	393,	'Folletos',	'2024-10-04 00:00:00.000',	'2024-10-04 00:00:00.000'),
('prod_832537',	'Tarjetas Personales 74',	'Descripción de tarjetas personales',	34.1,	37.51,	325,	'TarjetasPersonales',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_832784',	'Folletos 52',	'Descripción de folletos',	53.55,	81.32,	52,	'Folletos',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_838903',	'Libros 14',	'Descripción de libros',	78.04,	8.11,	324,	'libros',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_844677',	'Otros 53',	'Descripción de otros',	99.26,	7.25,	90,	'otros',	'2024-10-29 00:00:00.000',	'2024-10-29 00:00:00.000'),
('prod_847546',	'Tarjetas Personales 65',	'Descripción de tarjetas personales',	53.12,	18.18,	294,	'TarjetasPersonales',	'2024-12-01 00:00:00.000',	'2024-12-01 00:00:00.000'),
('prod_851276',	'Folletos 30',	'Descripción de folletos',	46.37,	24.44,	59,	'Folletos',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_856974',	'Libros 69',	'Descripción de libros',	58.37,	72.68,	22,	'libros',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_857417',	'Otros 53',	'Descripción de otros',	33.41,	86.29,	489,	'otros',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_859167',	'Otros 6',	'Descripción de otros',	6.7,	47.67,	216,	'otros',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000'),
('prod_863331',	'Tarjetas Personales 28',	'Descripción de tarjetas personales',	95.01,	16.54,	270,	'TarjetasPersonales',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_865021',	'Invitaciones 60',	'Descripción de invitaciones',	23.8,	57.39,	420,	'Invitaciones',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_875807',	'Invitaciones 56',	'Descripción de invitaciones',	8.47,	1.32,	295,	'Invitaciones',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_875833',	'Libros 15',	'Descripción de libros',	42.92,	32.81,	171,	'libros',	'2024-12-11 00:00:00.000',	'2024-12-11 00:00:00.000'),
('prod_879923',	'Tarjetas Personales 67',	'Descripción de tarjetas personales',	79.72,	18.76,	448,	'TarjetasPersonales',	'2024-09-01 00:00:00.000',	'2024-09-01 00:00:00.000'),
('prod_883103',	'Otros 42',	'Descripción de otros',	81.03,	79.59,	422,	'otros',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_884828',	'Tarjetas Personales 8',	'Descripción de tarjetas personales',	19.89,	75.65,	465,	'TarjetasPersonales',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_885369',	'Invitaciones 91',	'Descripción de invitaciones',	53.09,	39.56,	243,	'Invitaciones',	'2024-09-22 00:00:00.000',	'2024-09-22 00:00:00.000'),
('prod_885379',	'Invitaciones 49',	'Descripción de invitaciones',	21.3,	55.41,	356,	'Invitaciones',	'2024-11-02 00:00:00.000',	'2024-11-02 00:00:00.000'),
('prod_905787',	'Tarjetas Personales 93',	'Descripción de tarjetas personales',	97.26,	71.07,	463,	'TarjetasPersonales',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_916938',	'Libros 83',	'Descripción de libros',	49.03,	10.09,	141,	'libros',	'2025-01-15 00:00:00.000',	'2025-01-15 00:00:00.000'),
('prod_917963',	'Folletos 24',	'Descripción de folletos',	13.44,	29.08,	278,	'Folletos',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_924748',	'Tarjetas Personales 31',	'Descripción de tarjetas personales',	30.32,	22.29,	30,	'TarjetasPersonales',	'2024-12-03 00:00:00.000',	'2024-12-03 00:00:00.000'),
('prod_929332',	'Tarjetas Personales 72',	'Descripción de tarjetas personales',	53.6,	47.09,	176,	'TarjetasPersonales',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_941007',	'Libros 10',	'Descripción de libros',	60.83,	59.98,	310,	'libros',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_942432',	'Otros 27',	'Descripción de otros',	43.35,	79.47,	139,	'otros',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_944117',	'Folletos 15',	'Descripción de folletos',	99.31,	59.66,	168,	'Folletos',	'2024-10-16 00:00:00.000',	'2024-10-16 00:00:00.000'),
('prod_947933',	'Libros 75',	'Descripción de libros',	74.98,	44.62,	21,	'libros',	'2025-02-10 00:00:00.000',	'2025-02-10 00:00:00.000'),
('prod_959311',	'Folletos 42',	'Descripción de folletos',	37.01,	50.93,	50,	'Folletos',	'2024-11-10 00:00:00.000',	'2024-11-10 00:00:00.000'),
('prod_967838',	'Invitaciones 98',	'Descripción de invitaciones',	74.97,	5.97,	422,	'Invitaciones',	'2024-12-05 00:00:00.000',	'2024-12-05 00:00:00.000'),
('prod_971787',	'Otros 47',	'Descripción de otros',	67.11,	9.97,	456,	'otros',	'2025-02-10 00:00:00.000',	'2025-02-10 00:00:00.000'),
('prod_974289',	'Otros 52',	'Descripción de otros',	27.7,	89.1,	72,	'otros',	'2024-11-08 00:00:00.000',	'2024-11-08 00:00:00.000'),
('prod_977659',	'Folletos 9',	'Descripción de folletos',	89.31,	63.44,	414,	'Folletos',	'2025-01-18 00:00:00.000',	'2025-01-18 00:00:00.000'),
('prod_984918',	'Tarjetas Personales 84',	'Descripción de tarjetas personales',	49.82,	65.13,	295,	'TarjetasPersonales',	'2025-01-25 00:00:00.000',	'2025-01-25 00:00:00.000'),
('prod_989830',	'Libros 29',	'Descripción de libros',	49.45,	13.35,	93,	'libros',	'2024-12-24 00:00:00.000',	'2024-12-24 00:00:00.000'),
('prod_991037',	'Tarjetas Personales 33',	'Descripción de tarjetas personales',	97.31,	19.39,	305,	'TarjetasPersonales',	'2024-11-22 00:00:00.000',	'2024-11-22 00:00:00.000'),
('prod_995732',	'Folletos 9',	'Descripción de folletos',	6.26,	3.83,	256,	'Folletos',	'2024-09-02 00:00:00.000',	'2024-09-02 00:00:00.000');

INSERT INTO `Role` (`id`, `name`, `descripcion`, `createdAt`, `updatedAt`) VALUES
('administrador',	'ADMINISTRADOR',	'Rol que tiene control total',	'2025-03-05 15:41:58.000',	'2025-03-05 15:41:58.000'),
('vendedor',	'VENDEDOR',	'Usuario que solo tiene acceso a las ventas, lista de clientes',	'2025-03-05 15:42:53.000',	'2025-03-05 15:42:53.000');

INSERT INTO `User` (`id`, `first_name`, `last_name`, `username`, `password`, `codeExpireAt`, `createdAt`, `updatedAt`, `role`) VALUES
('58463cfd-94d8-11ef-92c1-0242ac120005',	'Raquel',	'Fernandez Ochoa',	'raquel',	'$2a$10$UpwqDBixGrKwxVm0mrv4Xe17iWbLDfG0jbszD5ATP0HkAEW7x9BtO',	NULL,	'2024-10-28 02:57:19.000',	'2024-10-28 02:57:19.000',	'ADMINISTRADOR'),
('e159dffe-f8c5-11ef-b895-0242ac120002',	'Vendedor',	'Vendedor',	'vendedor',	'sample',	NULL,	'2025-03-05 15:44:25.000',	'2025-03-05 15:44:25.000',	'VENDEDOR');

INSERT INTO `userRole` (`id`, `roleId`, `userId`) VALUES
('ca79d6cd-f8c5-11ef-b895-0242ac120002',	'administrador',	'58463cfd-94d8-11ef-92c1-0242ac120005'),
('f0155e50-f8c5-11ef-b895-0242ac120002',	'vendedor',	'e159dffe-f8c5-11ef-b895-0242ac120002');

-- 2025-03-05 15:45:20
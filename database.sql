-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: snpmb
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `akun_user`
--

DROP TABLE IF EXISTS `akun_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `akun_user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `tanggal_lahir` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(12) NOT NULL,
  `status_akun` enum('AKTIF','NONAKTIF') NOT NULL DEFAULT 'AKTIF',
  `tanggal_daftar_akun` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `akun_user`
--

LOCK TABLES `akun_user` WRITE;
/*!40000 ALTER TABLE `akun_user` DISABLE KEYS */;
INSERT INTO `akun_user` VALUES (7,'2008-08-28','user1@gmail.com','user123','AKTIF','2025-12-01 12:31:33'),(8,'2009-09-23','user@gmail.com','124','AKTIF','2025-12-01 12:42:49'),(10,'2008-09-03','didy@gmail.com','didy123','AKTIF','2025-12-01 15:09:17'),(11,'2009-09-09','dodit','dodit123','AKTIF','2025-12-01 15:32:56'),(12,'2009-09-09','agus@gmail.com','agus123','AKTIF','2025-12-01 15:40:24'),(13,'2009-09-09','azril@gmail.com','127','AKTIF','2025-12-01 15:46:10'),(14,'2008-09-12','bagas@gmail.com','128','AKTIF','2025-12-01 15:53:55');
/*!40000 ALTER TABLE `akun_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biodata`
--

DROP TABLE IF EXISTS `biodata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biodata` (
  `id_biodata` int NOT NULL AUTO_INCREMENT,
  `id_sekolah` int DEFAULT NULL,
  `nisn` varchar(20) NOT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `tempat_lahir` varchar(20) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jurusan` varchar(100) DEFAULT NULL,
  `tahun_lulus` int DEFAULT NULL,
  `status_eligible` enum('Eligible','Tidak_Eligible') NOT NULL DEFAULT 'Tidak_Eligible',
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_biodata`),
  UNIQUE KEY `biodata_nisn_unique` (`nisn`),
  KEY `biodata_id_sekolah_foreign` (`id_sekolah`),
  KEY `id_user_foreign` (`id_user`),
  CONSTRAINT `biodata_id_sekolah_foreign` FOREIGN KEY (`id_sekolah`) REFERENCES `sekolah_asal` (`id_sekolah`),
  CONSTRAINT `id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `akun_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biodata`
--

LOCK TABLES `biodata` WRITE;
/*!40000 ALTER TABLE `biodata` DISABLE KEYS */;
INSERT INTO `biodata` VALUES (1,1,'123','Dodit','f','2008-09-23','',2025,'Eligible',7),(2,2,'124','Agus','apua','2009-09-23','IPA',2025,'Tidak_Eligible',8),(3,1,'125','Didy','Jogja','2008-09-23','MIPA',2025,'Eligible',10),(9,2,'126','Agus','Jogja','2009-09-09','MIPA',2025,'Eligible',12),(10,2,'127','Azril','Jogja','2009-09-09','MIPA',2025,'Eligible',13),(11,4,'128','Bagas','Jogja','2008-09-12','MIPA',2025,'Tidak_Eligible',14),(12,NULL,'129',NULL,NULL,NULL,NULL,NULL,'Tidak_Eligible',NULL);
/*!40000 ALTER TABLE `biodata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasil_utbk`
--

DROP TABLE IF EXISTS `hasil_utbk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasil_utbk` (
  `id_hasil` int NOT NULL AUTO_INCREMENT,
  `subtes` varchar(50) NOT NULL,
  `skor` double NOT NULL,
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_hasil`),
  KEY `fk_id_user` (`id_user`),
  CONSTRAINT `fk_id_user` FOREIGN KEY (`id_user`) REFERENCES `akun_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasil_utbk`
--

LOCK TABLES `hasil_utbk` WRITE;
/*!40000 ALTER TABLE `hasil_utbk` DISABLE KEYS */;
INSERT INTO `hasil_utbk` VALUES (1,'All Subtes',495,8),(2,'All Subtes',693,14),(3,'All Subtes',990,10);
/*!40000 ALTER TABLE `hasil_utbk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nilai_rapor_snbp`
--

DROP TABLE IF EXISTS `nilai_rapor_snbp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nilai_rapor_snbp` (
  `id_nilai_rapor` int NOT NULL AUTO_INCREMENT,
  `rata_rata` decimal(8,2) NOT NULL,
  `semester` enum('1','2','3','4','5') DEFAULT NULL,
  PRIMARY KEY (`id_nilai_rapor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nilai_rapor_snbp`
--

LOCK TABLES `nilai_rapor_snbp` WRITE;
/*!40000 ALTER TABLE `nilai_rapor_snbp` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilai_rapor_snbp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendaftaran_snbp`
--

DROP TABLE IF EXISTS `pendaftaran_snbp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pendaftaran_snbp` (
  `id_snbp` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_prodi1` int NOT NULL,
  `id_prodi2` int DEFAULT NULL,
  `portofolio` varchar(255) DEFAULT NULL,
  `sertfikat` varchar(255) DEFAULT NULL,
  `tanggal_submit` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_biodata` int NOT NULL,
  PRIMARY KEY (`id_snbp`),
  KEY `pendaftaran_snbp_id_prodi1_foreign` (`id_prodi1`),
  KEY `id_biodata_foreign` (`id_biodata`),
  CONSTRAINT `id_biodata_foreign` FOREIGN KEY (`id_biodata`) REFERENCES `biodata` (`id_biodata`),
  CONSTRAINT `pendaftaran_snbp_id_prodi1_foreign` FOREIGN KEY (`id_prodi1`) REFERENCES `program_studi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendaftaran_snbp`
--

LOCK TABLES `pendaftaran_snbp` WRITE;
/*!40000 ALTER TABLE `pendaftaran_snbp` DISABLE KEYS */;
INSERT INTO `pendaftaran_snbp` VALUES (1,10,3,NULL,NULL,NULL,'2025-12-01 22:21:45',3),(2,10,2,NULL,NULL,NULL,'2025-12-01 23:02:06',3);
/*!40000 ALTER TABLE `pendaftaran_snbp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pendaftaran_snbt`
--

DROP TABLE IF EXISTS `pendaftaran_snbt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pendaftaran_snbt` (
  `id_snbt` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_biodata` int NOT NULL,
  `id_prodi1` int NOT NULL,
  `id_prodi2` int DEFAULT NULL,
  `tanggal_submit` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_snbt`),
  KEY `pendaftaran_snbt_id_biodata_foreign` (`id_biodata`),
  KEY `pendaftaran_snbt_id_prodi1_foreign` (`id_prodi1`),
  CONSTRAINT `pendaftaran_snbt_id_prodi1_foreign` FOREIGN KEY (`id_prodi1`) REFERENCES `program_studi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pendaftaran_snbt`
--

LOCK TABLES `pendaftaran_snbt` WRITE;
/*!40000 ALTER TABLE `pendaftaran_snbt` DISABLE KEYS */;
INSERT INTO `pendaftaran_snbt` VALUES (1,8,2,1,2,'2025-12-01 21:45:51'),(2,14,11,1,3,'2025-12-01 22:54:52'),(3,10,3,3,NULL,'2025-12-01 23:02:32');
/*!40000 ALTER TABLE `pendaftaran_snbt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengumuman`
--

DROP TABLE IF EXISTS `pengumuman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengumuman` (
  `id_pengumuman` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `jalur_seleksi` enum('SNBP','SNBT') NOT NULL DEFAULT 'SNBT',
  `hasil_akhir` enum('LULUS','TIDAK_LULUS') NOT NULL DEFAULT 'TIDAK_LULUS',
  PRIMARY KEY (`id_pengumuman`),
  KEY `pengumuman_id_user_foreign` (`id_user`),
  CONSTRAINT `pengumuman_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `akun_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengumuman`
--

LOCK TABLES `pengumuman` WRITE;
/*!40000 ALTER TABLE `pengumuman` DISABLE KEYS */;
INSERT INTO `pengumuman` VALUES (1,8,'SNBT','TIDAK_LULUS'),(2,14,'SNBT','LULUS'),(3,10,'SNBT','LULUS');
/*!40000 ALTER TABLE `pengumuman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_studi`
--

DROP TABLE IF EXISTS `program_studi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_studi` (
  `id_prodi` int NOT NULL AUTO_INCREMENT,
  `id_ptn` int NOT NULL,
  `nama_prodi` varchar(150) NOT NULL,
  `jenjang_prodi` enum('S1','D3','D4') NOT NULL DEFAULT 'S1',
  `akreditasi_prodi` varchar(255) NOT NULL,
  `persyaratan_khusus` varchar(255) NOT NULL DEFAULT '0',
  `kuota_snbp` int NOT NULL,
  `n=kuota_snbt` int NOT NULL,
  PRIMARY KEY (`id_prodi`),
  KEY `program_studi_id_ptn_foreign` (`id_ptn`),
  CONSTRAINT `program_studi_id_ptn_foreign` FOREIGN KEY (`id_ptn`) REFERENCES `ptn` (`id_ptn`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_studi`
--

LOCK TABLES `program_studi` WRITE;
/*!40000 ALTER TABLE `program_studi` DISABLE KEYS */;
INSERT INTO `program_studi` VALUES (1,1,'Teknik Informatika','S1','A','0',20,24),(2,2,'Filsafat','S1','A','0',34,43),(3,2,'Teknik Nuklir','S1','A','0',34,43);
/*!40000 ALTER TABLE `program_studi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ptn`
--

DROP TABLE IF EXISTS `ptn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ptn` (
  `id_ptn` int NOT NULL AUTO_INCREMENT,
  `kode_ptn` int NOT NULL,
  `nama_ptn` varchar(100) NOT NULL,
  `akreditasi_ptn` varchar(255) NOT NULL,
  `provinsi_ptn` varchar(255) NOT NULL,
  PRIMARY KEY (`id_ptn`),
  UNIQUE KEY `ptn_kode_ptn_unique` (`kode_ptn`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ptn`
--

LOCK TABLES `ptn` WRITE;
/*!40000 ALTER TABLE `ptn` DISABLE KEYS */;
INSERT INTO `ptn` VALUES (1,123,'Universitas Dokter Tirta','A','Jawa Timur'),(2,124,'Universitas Indonesia','A','Jakarta');
/*!40000 ALTER TABLE `ptn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sekolah_asal`
--

DROP TABLE IF EXISTS `sekolah_asal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sekolah_asal` (
  `id_sekolah` int NOT NULL AUTO_INCREMENT,
  `npsn_sekolah` varchar(20) NOT NULL,
  `nama_sekolah` varchar(100) NOT NULL,
  `provinsi_sekolah` varchar(100) NOT NULL,
  `akreditasi_sekolah` enum('A','B','C') NOT NULL DEFAULT 'C',
  PRIMARY KEY (`id_sekolah`),
  UNIQUE KEY `sekolah_asal_npsn_sekolah_unique` (`npsn_sekolah`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sekolah_asal`
--

LOCK TABLES `sekolah_asal` WRITE;
/*!40000 ALTER TABLE `sekolah_asal` DISABLE KEYS */;
INSERT INTO `sekolah_asal` VALUES (1,'123','SMAN 1 Ngawi','Ngawi','A'),(2,'124','SMAN 1 Yogyakarta','DIY','A'),(3,'125','SMAN 2 Yogyakarta','DIY','A'),(4,'126','SMAN 3 Yogyakarta','DIY','A');
/*!40000 ALTER TABLE `sekolah_asal` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-01 23:06:11

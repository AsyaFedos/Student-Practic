CREATE DATABASE  IF NOT EXISTS `pm02_practic` /*!40100 DEFAULT CHARACTER SET cp1251 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pm02_practic`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pm02_practic
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id_event` int NOT NULL AUTO_INCREMENT,
  `time_event` varchar(20) NOT NULL,
  `title_event` varchar(300) NOT NULL,
  `description_event` varchar(1500) DEFAULT NULL,
  `speakers_event` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_event`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'9:00 - 19:00','Выставка производителей пермского и российского интерьерного и строительного рынка','Консультации дизайнеров интерьера для пермяков.',NULL),(2,'10:00','Торжественное открытие выставки «Знай Наших!»',NULL,NULL),(3,'11:00','Инновационные технологии в мебельном производстве, нестинг, полный цикл производства','Основатель и руководитель компании GILMANOV mebel. Эксперт, наставник, и известный блогер в сфере мебельного производства. Автор собственной методики отладки производственного цикла с использованием современных технологий','Гильманов Ильдар, г.Пермь'),(4,'12:00','Флиппинг объекты. Как с ними работать и особенности интерьерного рынка в Перми','ДИЗАЙНЕР - в профессии более 18 лет<br />РУКОВОДИТЕЛЬ - собственной студии AD designer<br />СПИКЕР  - PermExpo с темой «Картина в интерьере»<br />СПИКЕР - обучающих  мероприятий для застройщиков и новоселов с темой  «Ремонт - это просто если есть инструкция к применению»<br />СПИКЕР на профессиональной площадке для молодых дизайнеров «Дизайн перспектива»<br />','Анна Двинина, г.Пермь'),(5,'13:00','Урок-Практикум №1: Эффективная работа с аудиторией и целевые продажи','* Спиральная динамика — как определить уровни своего продукта и доносить нужные смыслы?<br />* Эннеаграмма — как продавать любой продукт в любой нише?<br />* Позиционирование на 360 градусов','Даниил Зязев, г.Пермь'),(6,'14:00','Профессия дизайнер. Новый взгляд на привычное. Тенденции нового времени','КРЕАТИВНЫЙ ИДЕОЛОГ. Основатель студии декора событий и пространств «Издательство Красоты» - создание декора для ивентов в B2B сегменте более 15 лет, искусственное  озеленение ресторанов, декор входных групп, витрины.<br /><br />Педагогическое художественно-графическое образование, закончила с красным дипломом.<br /><br />Ведущая  серии творческих мастер-классов на телеканале Рифей-Пермь','Анна Полякова, г.Пермь');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` varchar(90) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `registered` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'u1@rambler.ru','$2b$10$jirk99RSaapfxZP/xQuY8eX25Ifq.IBvHrM7pwCfs3UsnYB2zKKaS',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-24 14:06:59

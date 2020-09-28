-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 28-09-2020 a las 23:17:33
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `placemybet`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apuesta`
--

CREATE TABLE `apuesta` (
  `id_apuesta` int(11) NOT NULL,
  `email_usuario` varchar(100) NOT NULL COMMENT 'fk_usuario',
  `id_mercado` int(11) NOT NULL COMMENT 'fk_mercado',
  `cuota_apuesta` decimal(10,2) NOT NULL,
  `dinero_apuesta` int(11) NOT NULL,
  `fecha_apuesta` datetime NOT NULL,
  `tipo_apuesta` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `apuesta`
--

INSERT INTO `apuesta` (`id_apuesta`, `email_usuario`, `id_mercado`, `cuota_apuesta`, `dinero_apuesta`, `fecha_apuesta`, `tipo_apuesta`) VALUES
(1, 'inma@gmail.com', 1, '1.43', 50, '2020-09-28 23:14:26', 'over'),
(2, 'pepe@gmail.com', 4, '2.85', 100, '2020-09-29 23:14:26', 'under');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `id_cuenta` int(11) NOT NULL,
  `email_usuario` varchar(100) NOT NULL COMMENT 'fk_usuario',
  `saldo_actual` int(11) NOT NULL,
  `nombre_banco` varchar(100) NOT NULL,
  `numero_tarjeta` varchar(20) NOT NULL,
  `cuenta_activa` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`id_cuenta`, `email_usuario`, `saldo_actual`, `nombre_banco`, `numero_tarjeta`, `cuenta_activa`) VALUES
(1, 'inma@gmail.com', 100, 'ING DIRECT', '1111 2222 3333 4444', 0),
(2, 'pepe@gmail.com', 200, 'BANKIA', '8888 5555 9999 4444', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL COMMENT 'fk_mercado',
  `equipo_local` varchar(100) NOT NULL,
  `equipo_visitante` varchar(100) NOT NULL,
  `fecha_evento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id_evento`, `equipo_local`, `equipo_visitante`, `fecha_evento`) VALUES
(1, 'Valencia', 'Levante', '2020-09-29 22:59:37'),
(2, 'Osasuna', 'Atlético de Madrid', '2020-09-30 22:59:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mercado`
--

CREATE TABLE `mercado` (
  `id_mercado` int(11) NOT NULL,
  `cuota_over` decimal(10,2) NOT NULL,
  `cuota_under` decimal(10,2) NOT NULL,
  `dinero_over` int(11) NOT NULL,
  `dinero_under` int(11) NOT NULL,
  `tipo` decimal(2,1) NOT NULL,
  `id_evento` int(11) NOT NULL COMMENT 'fk_evento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mercado`
--

INSERT INTO `mercado` (`id_mercado`, `cuota_over`, `cuota_under`, `dinero_over`, `dinero_under`, `tipo`, `id_evento`) VALUES
(1, '1.43', '2.85', 100, 50, '1.5', 1),
(2, '1.90', '1.90', 100, 100, '2.5', 1),
(3, '1.43', '2.85', 100, 20, '3.5', 1),
(4, '2.85', '1.43', 50, 100, '3.5', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `email_usuario` varchar(100) NOT NULL COMMENT 'fk_cuenta',
  `nombre_usuario` varchar(100) NOT NULL,
  `apellidos_usuario` varchar(100) NOT NULL,
  `edad_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`email_usuario`, `nombre_usuario`, `apellidos_usuario`, `edad_usuario`) VALUES
('inma@gmail.com', 'Inma', 'Prieto', 33),
('pepe@gmail.com', 'Pepe', 'Martínez', 80);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apuesta`
--
ALTER TABLE `apuesta`
  ADD PRIMARY KEY (`id_apuesta`),
  ADD KEY `fk_usuario` (`email_usuario`),
  ADD KEY `fk_mercado` (`id_mercado`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`id_cuenta`),
  ADD UNIQUE KEY `email_usuario` (`email_usuario`),
  ADD KEY `fk_usuario` (`email_usuario`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_evento` (`id_evento`);

--
-- Indices de la tabla `mercado`
--
ALTER TABLE `mercado`
  ADD PRIMARY KEY (`id_mercado`),
  ADD KEY `fk_evento` (`id_evento`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`email_usuario`),
  ADD UNIQUE KEY `email_usuario` (`email_usuario`),
  ADD KEY `email_usuario_2` (`email_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_mercado', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `mercado`
--
ALTER TABLE `mercado`
  MODIFY `id_mercado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `apuesta`
--
ALTER TABLE `apuesta`
  ADD CONSTRAINT `apuesta_ibfk_1` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `apuesta_ibfk_2` FOREIGN KEY (`email_usuario`) REFERENCES `cuenta` (`email_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`email_usuario`) REFERENCES `usuario` (`email_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `mercado`
--
ALTER TABLE `mercado`
  ADD CONSTRAINT `mercado_ibfk_1` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

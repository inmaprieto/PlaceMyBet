-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-09-2020 a las 01:46:11
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
  `id_usuario` int(11) NOT NULL COMMENT 'fk_usuario',
  `id_mercado` int(11) NOT NULL COMMENT 'fk_mercado',
  `cuota_apuesta` decimal(10,1) NOT NULL,
  `dinero_apuesta` int(11) NOT NULL,
  `fecha_apuesta` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `apuesta`
--

INSERT INTO `apuesta` (`id_apuesta`, `id_usuario`, `id_mercado`, `cuota_apuesta`, `dinero_apuesta`, `fecha_apuesta`) VALUES
(1, 1, 1, '1.3', 50, '2020-09-25 01:38:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE `cuenta` (
  `id_cuenta` int(11) NOT NULL,
  `saldo_actual` int(11) NOT NULL,
  `nombre_banco` varchar(100) NOT NULL,
  `numero_tarjeta` varchar(100) NOT NULL,
  `id_usuario` int(11) NOT NULL COMMENT 'fk_usuario, unico',
  `cuenta_activa` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta`
--

INSERT INTO `cuenta` (`id_cuenta`, `saldo_actual`, `nombre_banco`, `numero_tarjeta`, `id_usuario`, `cuenta_activa`) VALUES
(1, 100, 'ING DIRECT', '1111 2222 3333 4444', 1, 0),
(2, 200, 'BANKIA', '2222 3333 4444 5555', 2, 0),
(3, 50, 'CaixaBank', '6666 7777 8888 9999', 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota`
--

CREATE TABLE `cuota` (
  `id_cuota` int(11) NOT NULL COMMENT 'fk_mercado',
  `cantidad_cuota` decimal(10,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuota`
--

INSERT INTO `cuota` (`id_cuota`, `cantidad_cuota`) VALUES
(1, '1.5'),
(2, '2.5'),
(3, '3.5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL COMMENT 'fk_evento',
  `nombre_evento` varchar(30) NOT NULL,
  `equipo_local` varchar(30) NOT NULL,
  `equipo_visitante` varchar(30) NOT NULL,
  `fecha_evento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id_evento`, `nombre_evento`, `equipo_local`, `equipo_visitante`, `fecha_evento`) VALUES
(1, 'Partido 1', 'Valencia', 'Levante', '2020-09-24 01:34:59'),
(2, 'Partido 2', 'Betis', 'Manchester', '2020-09-26 01:34:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mercado`
--

CREATE TABLE `mercado` (
  `id_mercado` int(11) NOT NULL COMMENT 'fk_evento',
  `id_cuota` int(11) NOT NULL COMMENT 'fk_cuota',
  `dinero_mercado` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL COMMENT 'fk_tipo',
  `id_evento` int(11) NOT NULL COMMENT 'fk_evento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mercado`
--

INSERT INTO `mercado` (`id_mercado`, `id_cuota`, `dinero_mercado`, `id_tipo`, `id_evento`) VALUES
(1, 1, 100, 1, 1),
(2, 1, 50, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL COMMENT 'fk_mercado',
  `nombre_tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'over'),
(2, 'under');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL COMMENT 'fk_cuenta',
  `email_usuario` varchar(100) NOT NULL COMMENT 'unico',
  `nombre_usuario` varchar(100) NOT NULL,
  `apellidos_usuario` varchar(100) NOT NULL,
  `edad_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `email_usuario`, `nombre_usuario`, `apellidos_usuario`, `edad_usuario`) VALUES
(1, 'inmaprieto@gmail.com', 'Inma', 'Prieto Zahonero', 33),
(2, 'pepemartinez@gmail.com', 'Pepe', 'Martínez Zahonero', 80),
(3, 'davidsanchis@gmail.com', 'David', 'Sanchis Zahonero', 40);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apuesta`
--
ALTER TABLE `apuesta`
  ADD PRIMARY KEY (`id_apuesta`),
  ADD KEY `fk_usuario` (`id_usuario`),
  ADD KEY `fk_mercado` (`id_mercado`);

--
-- Indices de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD PRIMARY KEY (`id_cuenta`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `fk_usuario` (`id_usuario`);

--
-- Indices de la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD PRIMARY KEY (`id_cuota`),
  ADD KEY `id_cuota` (`id_cuota`);

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
  ADD KEY `fk_cuota` (`id_cuota`),
  ADD KEY `fk_tipo` (`id_tipo`),
  ADD KEY `id_mercado` (`id_mercado`),
  ADD KEY `fk_evento` (`id_evento`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id_tipo`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `un_email` (`email_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `apuesta`
--
ALTER TABLE `apuesta`
  MODIFY `id_apuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cuenta`
--
ALTER TABLE `cuenta`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuota`
--
ALTER TABLE `cuota`
  MODIFY `id_cuota` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_mercado', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_evento', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `mercado`
--
ALTER TABLE `mercado`
  MODIFY `id_mercado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_evento', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_mercado', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'fk_cuenta', AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `apuesta`
--
ALTER TABLE `apuesta`
  ADD CONSTRAINT `apuesta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `apuesta_ibfk_2` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuenta`
--
ALTER TABLE `cuenta`
  ADD CONSTRAINT `cuenta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `mercado`
--
ALTER TABLE `mercado`
  ADD CONSTRAINT `mercado_ibfk_1` FOREIGN KEY (`id_cuota`) REFERENCES `cuota` (`id_cuota`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mercado_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mercado_ibfk_3` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

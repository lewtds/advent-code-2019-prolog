:- dynamic(mark/2).

% The idea is to trace the steps and mark all the crossings as we trace.

trace_path(Symbol, X-Y, [Step | Rest]) :-
    trace_step(Symbol, X-Y, Step, X2-Y2),
    trace_path(Symbol, X2-Y2, Rest).

trace_path(_, _, []).

mark_crossing(Symbol, X-Y) :-
    (mark(Sym2, X-Y), Symbol \= Sym2) -> assertz(crossing(X-Y)); true.

% TODO lots of duplication
trace_step(Symbol, X-Y, EndingMove, X-Y) :-
    (
        EndingMove = right(0); EndingMove = left(0); EndingMove = up(0); EndingMove = down(0)
    ), !,
    mark_crossing(Symbol, X-Y),
    assertz(mark(Symbol, X-Y)).

trace_step(Symbol, X-Y, up(N), EndingPos) :-
    mark_crossing(Symbol, X-Y),
    assertz(mark(Symbol, X-Y)),
    NextY is Y + 1,
    NextN is N - 1,
    trace_step(Symbol, X-NextY, up(NextN), EndingPos).

trace_step(Symbol, X-Y, down(N), EndingPos) :-
    mark_crossing(Symbol, X-Y),
    assertz(mark(Symbol, X-Y)),
    NextY is Y - 1,
    NextN is N - 1,
    trace_step(Symbol, X-NextY, down(NextN), EndingPos).

trace_step(Symbol, X-Y, left(N), EndingPos) :-
    mark_crossing(Symbol, X-Y),
    assertz(mark(Symbol, X-Y)),
    NextX is X - 1,
    NextN is N - 1,
    trace_step(Symbol, NextX-Y, left(NextN), EndingPos).

trace_step(Symbol, X-Y, right(N), EndingPos) :-
    mark_crossing(Symbol, X-Y),
    assertz(mark(Symbol, X-Y)),
    NextX is X + 1,
    NextN is N - 1,
    trace_step(Symbol, NextX-Y, right(NextN), EndingPos).

distance(X-Y, X2-Y2, Distance) :- Distance is abs(X2 - X) + abs(Y2 - Y).

init_board :-
    retractall(mark(_, _, _)),
    % TODO write a parser for the puzzle input
    trace_path(a, 1-1, [right(1003),up(741),left(919),up(341),left(204),up(723),left(113),down(340),left(810),down(238),right(750),up(409),left(104),up(65),right(119),up(58),right(94),down(738),left(543),up(702),right(612),down(998),left(580),up(887),right(664),down(988),right(232),down(575),right(462),up(130),left(386),up(386),left(217),up(155),left(68),up(798),right(792),up(149),left(573),down(448),right(76),up(896),left(745),down(640),left(783),down(19),right(567),down(271),right(618),up(677),left(449),down(651),left(843),down(117),left(636),up(329),right(484),up(853),left(523),up(815),left(765),up(834),left(500),up(321),right(874),up(90),right(473),up(31),right(846),up(549),left(70),up(848),right(677),down(557),left(702),up(90),right(78),up(234),right(282),down(289),left(952),down(514),right(308),up(255),right(752),down(338),left(134),down(335),left(207),up(167),right(746),up(328),left(65),down(579),right(894),up(716),right(510),down(932),left(396),up(766),left(981),down(115),left(668),up(197),right(773),up(898),left(22),up(294),left(548),down(634),left(31),up(626),right(596),up(442),left(103),up(448),right(826),up(511),right(732),up(680),left(279),down(693),right(292),up(641),right(253),up(977),right(699),up(861),right(534),down(482),left(481),up(929),left(244),up(863),left(951),down(744),right(775),up(198),left(658),up(700),left(740),up(725),right(286),down(105),left(629),down(117),left(991),down(778),left(627),down(389),right(942),down(17),left(791),down(515),right(231),up(418),left(497),down(421),left(508),up(91),right(841),down(823),left(88),up(265),left(223),down(393),left(399),down(390),left(431),down(553),right(40),up(724),left(566),up(121),left(436),up(797),left(42),up(13),right(19),down(858),right(912),down(571),left(207),down(5),left(981),down(996),right(814),down(918),left(16),up(872),left(5),up(281),right(706),up(596),right(827),down(19),right(976),down(664),left(930),up(56),right(168),down(892),right(661),down(751),right(219),up(343),right(120),up(21),left(659),up(976),right(498),up(282),right(1),up(721),right(475),down(798),left(5),up(396),right(268),down(454),right(118),up(260),left(709),down(369),right(96),down(232),left(320),down(763),right(548),up(670),right(102),down(253),left(947),up(845),right(888),down(645),left(734),down(734),left(459),down(638),left(82),up(933),left(485),up(235),right(181),down(51),left(45),down(979),left(74),down(186),left(513),up(974),right(283),down(493),right(128),up(909),left(96),down(861),left(291),up(640),right(793),down(712),right(421),down(315),left(152),up(220),left(252),up(642),right(126),down(417),right(137),down(73),right(1),down(711),right(880),up(718),right(104),up(444),left(36),down(974),left(360),up(12),left(890),down(337),right(184),down(745),right(164),down(931),right(915),down(999),right(452),up(221),left(399),down(761),left(987),up(562),right(25),down(642),right(411),down(605),right(964)]),
    trace_path(b, 1-1, [left(1010),up(302),left(697),down(105),right(618),up(591),right(185),up(931),right(595),down(881),left(50),down(744),left(320),down(342),left(221),down(201),left(862),down(959),right(553),down(135),left(238),up(719),left(418),up(798),right(861),up(80),left(571),up(774),left(896),up(772),left(960),up(368),right(415),down(560),right(276),up(33),left(532),up(957),right(621),down(137),right(373),up(53),left(842),up(118),left(299),up(203),left(352),down(531),right(118),up(816),right(355),up(678),left(983),down(175),right(652),up(230),right(190),down(402),right(111),down(842),right(756),down(961),left(82),up(206),left(576),up(910),right(622),down(494),right(630),down(893),left(200),up(943),left(696),down(573),left(143),down(640),left(885),down(184),left(52),down(96),left(580),up(204),left(793),down(806),right(477),down(651),left(348),down(318),left(924),down(700),right(675),down(689),left(723),down(418),left(156),down(215),left(943),down(397),left(301),up(350),right(922),down(721),right(14),up(399),left(774),up(326),left(14),down(465),left(65),up(697),right(564),down(4),left(40),down(250),right(914),up(901),right(316),up(366),right(877),down(222),left(672),down(329),left(560),up(882),right(321),down(169),right(161),up(891),left(552),up(86),left(194),down(274),left(567),down(669),left(682),up(60),left(985),up(401),right(587),up(569),left(1),down(325),left(73),up(814),left(338),up(618),left(49),up(67),left(258),down(596),right(493),down(249),left(310),down(603),right(810),down(735),left(829),down(378),right(65),up(85),left(765),down(854),left(863),up(989),left(595),up(564),left(373),up(76),right(923),up(760),left(965),up(458),left(610),up(461),right(900),up(151),left(650),down(437),left(1),up(464),left(65),down(349),right(256),down(376),left(686),up(183),left(403),down(354),right(867),up(993),right(819),down(333),left(249),up(466),left(39),down(878),right(855),up(166),left(254),down(532),left(909),up(48),left(980),up(652),right(393),down(291),left(502),up(230),left(738),up(681),left(393),up(935),left(333),down(139),left(499),down(813),right(302),down(415),left(693),down(404),left(308),down(603),right(968),up(753),left(510),down(356),left(356),up(620),right(386),down(205),right(587),up(212),right(715),up(360),left(603),up(792),right(58),up(619),right(73),down(958),left(53),down(666),left(756),up(71),left(621),down(576),left(174),up(779),left(382),up(977),right(890),down(830),right(822),up(312),right(716),up(767),right(36),up(340),right(322),down(175),left(417),up(710),left(313),down(526),left(573),down(90),left(493),down(257),left(918),up(425),right(93),down(552),left(691),up(792),right(189),up(43),left(633),up(934),left(953),up(817),left(404),down(904),left(384),down(15),left(670),down(889),left(648),up(751),left(928),down(744),left(932),up(761),right(879),down(229),right(491),up(902),right(134),down(219),left(634),up(423),left(241)]).


crossing_points(Out) :-
    setof(Distance-X-Y, (crossing(X-Y), distance(1-1, X-Y, Distance)), Out).

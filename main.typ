#set page("us-letter")
#set text(
  lang: "cs",
  // font: "New Computer Modern Math",
  //font: "MesloLGM Nerd Font",
  size: 11pt,
)

#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(left)
  #set text(24pt, weight: "regular")
  #text(it.body)
]

#show heading.where(
  level: 2
): it => block(width: 100%)[
  #set align(left)
  #set text(16pt, weight: "regular")
  #text(it.body)
]

// Title page
#set page(fill: rgb("EAF2F5"), margin: (left: 1in))
#line(start: (20%, 5%), end: (8.5in, 5%), stroke: (thickness: 1pt))
#align(right + top)[
  Vysoká škola báňská - Technická univerzita Ostrava \
  Fakulta elektrotechniky a informatiky
]

#align(horizon + center)[

  #text(size: 24pt, [*Počítačové sítě*]) \
  #text(size: 16pt, [Semestrální projekt]) \ \
  // _Phat Tran Dai_ (TRA0163) & _Vuong Tran Dai_ (TRA0164)

]

#align(horizon)[
  #grid(
    columns: (1fr, 1fr),
    align(center)[
      Phat Tran Dai \
      #link("mailto:tra0163@vsb.cz")
    ],
    align(center)[
      Vuong Tran Dai \
      #link("mailto:tra0164@vsb.cz")
    ]
  )
]

#align(bottom + left)[
  *Cvičící:* Daniel Stříbný\
  *Skupina:* Pondělí 14:15-16:45\
  *Akademický rok:* 2024/2025
]
#set page(fill: none, margin: (left: 1in, right: 1in))

#set page(footer: context(
  smallcaps([
  #h(1fr)
  #counter(page).display(
    "[1/1]",
    both: true,
  )
  ])),
  header: align(right)[Semestrální projekt]
)

#set page(fill: none, margin: (left: 1in, right: 1in, top: 1in))
#counter(page).update(1)
= Specifikace zadání
\
#figure(
table(
  columns: 2,
  align: (left, left),
  fill: (rgb("EAF2F5"), none),
  stroke: 0.8pt + rgb("323232"),
  [*Firma*], [benee],
  [*Číslo topologie*], [H],
  [*Čísla VLAN*], [VLAN A=108, VLAN B=133, VLAN C=158],
  [*Počty stanic na segmentech*], [VLAN A=269, VLAN B=9],
  [*Rozsah veřejných adres*], [202.206.128.0/17],
  [*Rozsah privátních adres*], [172.17.75.192/27],
  [*Rozsah IPv6 adres*], [2002:d1ec:211a:7000::/52],
  [*Zvláštní segmenty*], [
    *NAT:* VLAN B;\ 
    *DNS:* VLAN A (PC2A)\;
    *DHCP:* VLAN A;\
    *T:* VLAN A; *N:* VLAN A],
  [*NAT pool*], [24],
  [*Směrovací protokol*], [RIP],
))
\ 
#figure(
  image("./pos_firma_ips.drawio.svg", width: 50%),
  caption: [Popis sítě firmy a IPS],
)

#pagebreak()

= Schéma základní topologie
Zadaná topologie (topologie H) sítě s barevně vyznačenými virtualními sítěmi.
\ \ \

#figure(
  image("./pos_project.drawio.svg", width: 70%),
    caption: [Schéma základní topologie]
)

#pagebreak()

= Navržená L3 topologie 
Schéma vyznačuje topologii sítě z pohledu aktivních prvků třetí vrstvy.
\ \
#figure(
  image("./l3_topologie.drawio.svg", width: 90%),
  caption: [Navržená L3 topologie]
)

#pagebreak()

= Adresní plán IPv4 (VLSM)

Plán adres IPv4 s přiděleným (veřejným) prefixem 202.206.128.0/17.

== Veřejný rozsah

#figure(table(
  // columns: 5,
  columns: (0.7fr, 1.2fr, 1.2fr, 1.2fr, 1fr),
  // align: (left, left, left, left, left),
  fill: (rgb("EAF2F5"), none),
  stroke: 0.8pt + rgb("323232"),
  table.header[*Název segmentu*][*Adresa podsítě/Maska*][*Nejnižší použitelná adresa*][*Nejvyšší použitelná adresa*][*Adresa broadcastu*],
  [VLAN A],[202.206.128.0/23],[202.206.128.1],[202.206.129.254],[202.206.129.255],
  [NAT pool],[202.206.130.0/27],[202.206.130.1],[202.206.130.30],[202.206.130.31],
  [R1-R2],[202.206.130.32/30],[202.206.130.33],[202.206.130.34],[202.206.130.35],
  [R1-R3],[202.206.130.36/30],[202.206.130.37],[202.206.130.38],[202.206.130.39],
  [R2-R3],[202.206.130.40/30],[202.206.130.41],[202.206.130.42],[202.206.130.43],
))

== Privátní rozsah

Přidělená privátní adresa je 172.17.75.192/27.

#table(
  columns: (0.7fr, 1.2fr, 1.2fr, 1.2fr, 1fr),
  align: (center, center, center, center, center),
  fill: (rgb("EAF2F5"), none),
  stroke: 0.8pt + rgb("323232"),
  table.header[*Název segmentu*][*Adresa podsítě/Maska*][*Nejnižší použitelná adresa*][*Nejvyšší použitelná adresa*][*Adresa broadcastu*],
  [VLAN B],[172.17.75.192/28],[172.17.75.193],[172.17.75.206],[202.206.129.207],
)

== R1-ISP

Adresa mezi směrovačem R1 a směrovačem od IPS.

#table(
  columns: (0.7fr, 1.2fr, 1.2fr, 1.2fr, 1fr),
  align: (center, center, center, center, center),
  fill: (rgb("EAF2F5"), none),
  stroke: 0.8pt + rgb("323232"),
  table.header[*Název segmentu*][*Adresa podsítě/Maska*][*Nejnižší použitelná adresa*][*Nejvyšší použitelná adresa*][*Adresa broadcastu*],
  [VLAN C],[10.0.0.0/30],[10.0.0.1],[10.0.0.2],[10.0.0.3]
)

== Adresy bran a stanic

#grid(
  columns: (1fr, 1fr),
  align(horizon)[
    #figure(
      table(
        columns: 2,
        fill: (rgb("EAF2F5"), none),
        stroke: 0.8pt + rgb("323232"),
        table.header[*Označení rozhraní*][*Adresa*],
        [VLAN A-R3],[202.206.128.1],
        [VLAN B-R2],[172.17.75.193],
        [VLAN C-R1],[10.0.0.2],
        [(R1-R2) R1],[202.206.130.33],
        [(R1-R2) R2],[202.206.130.34],
        [(R1-R3) R1],[202.206.130.37],
        [(R1-R3) R3],[202.206.130.38],
        [(R2-R3) R2],[202.206.130.41],
        [(R2-R3) R3],[202.206.130.42],
      ),
      caption: [Adresy IPv4 výchozích \ a alternativních bran]
    )
  ],
  align(horizon)[
    #figure(
      table(
        columns: 2,
        // align: (left, left),
        fill: (rgb("EAF2F5"), none),
        stroke: 0.8pt + rgb("323232"),
        table.header[*Označení rozhraní*][*Adresa*],
        [PC1A],[202.206.129.253],
        [PC2A (DNS)],[202.206.129.254],
        [PC1B],[172.17.75.205],
        [PC2B],[172.17.75.206],
      ),
      caption: [Adresy IPv4 přidělené stanicím]
    )
  ]
)

= Adresní plán IPv6

Plán adres IPv6 s přiděleným prefixem 2002:d1ec:211a:7000::/52.
Zkratka `<pre>` je zde označení pro 2002:d1ec:211a 
(tedy šest prvních bytů IPv6 adresy).

== Veřejný rozsah
#figure(
  table(
    // columns: 5,
    columns: (0.6fr, 0.8fr, 1fr, 1.1fr),
    fill: (rgb("EAF2F5"), none),
    stroke: 0.8pt + rgb("323232"),
    table.header[*Název segmentu*][*Adresa podsítě/Maska*][*Nejnižší použitelná adresa*][*Nejvyšší použitelná adresa*],
    [NAT pool],[\<pre\>:7000::/64],[\<pre\>:7000::1],[\<pre\>:7000:ffff:ffff:ffff:ffff],
    [VLAN A],[\<pre\>:7001::/64],[\<pre\>:7001::1],[\<pre\>:7001:ffff:ffff:ffff:ffff],
    [VLAN B],[\<pre\>:7002::/64],[\<pre\>:7002::1],[\<pre\>:7002:ffff:ffff:ffff:ffff],
    [VLAN C],[\<pre\>:7003::/64],[\<pre\>:7003::1],[\<pre\>:7003:ffff:ffff:ffff:ffff],
    [R1-R2],[\<pre\>:7004::/64],[\<pre\>:7004::1],[\<pre\>:7004:ffff:ffff:ffff:ffff],
    [R1-R3],[\<pre\>:7005::/64],[\<pre\>:7005:1],[\<pre\>:7005:ffff:ffff:ffff:ffff],
    [R2-R3],[\<pre\>:7006::/64],[\<pre\>:7006:1],[\<pre\>:7006:ffff:ffff:ffff:ffff],
  ),
  caption: [Rozsahy veřejných adres IPv6 v jednotlivích podsítích]
)

== Adresy bran a stanic

#grid(
  columns: (1fr, 1fr),
  align(horizon)[
    #figure(
      table(
        columns: 2,
        fill: (rgb("EAF2F5"), none),
        stroke: 0.8pt + rgb("323232"),
        table.header[*Označení rozhraní*][*Adresa*],
        [VLAN A-R3],[\<pre\>:7001::1],
        [VLAN B-R2],[\<pre\>:7002::1],
        [VLAN C-R1],[10.0.0.2],
        [(R1-R2) R1],[\<pre\>:7004::1],
        [(R1-R2) R2],[\<pre\>:7004::2],
        [(R1-R3) R1],[\<pre\>:7005::1],
        [(R1-R3) R3],[\<pre\>:7005::2],
        [(R2-R3) R2],[\<pre\>:7006::1],
        [(R2-R3) R3],[\<pre\>:7006::2],
      ),
      caption: [Adresy IPv6 výchozích \ a alternativních bran]
    )
  ],
  align(horizon)[
    #figure(
      table(
        columns: (1.2fr, 2fr),
        // align: (left, left),
        fill: (rgb("EAF2F5"), none),
        stroke: 0.8pt + rgb("323232"),
        table.header[*Označení rozhraní*][*Adresa*],
        [PC1A],[\<pre\>:7001:ffff:ffff:ffff:ffff],
        [PC2A (DNS)],[\<pre\>:7001:ffff:ffff:ffff:fffe],
        [PC1B],[\<pre\>:7002:ffff:ffff:ffff:ffff],
        [PC2B],[\<pre\>:7002:ffff:ffff:ffff:fffe],
      ),
      caption: [Adresy IPv6 přidělené stanicím]
    )
  ]
)

#pagebreak()

= Schéma základní topologie s adresami
 
Zkratka `<pre>` je zde opět označení pro 2002:d1ec:211a (prvních šest bytů IPv6 adresy).
\ \
#figure(
  image("./topologie_s_adresami.drawio.svg", width: 70%),
    caption: [Schéma základní topologie s adresami IPv4 a IPv6 (dual stack)]
)

#pagebreak()

= Navržená L3 topologie s adresami

Zkratka `<pre>` je označení pro 2002:d1ec:211a (prvních šest bytů IPv6 adresy).
\ \
#figure(
  image("./l3_topologie_s_adresami.drawio.svg", width: 90%),
  caption: [Navržená L3 topologie s adresami IPv4 a IPv6 (dual stack)]
)




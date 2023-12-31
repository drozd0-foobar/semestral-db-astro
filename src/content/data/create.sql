CREATE TABLE adopce (
    id_adopce SERIAL NOT NULL,
    id_zakaznik INTEGER NOT NULL,
    nazev VARCHAR(40) NOT NULL,
    jmeno_zivocicha VARCHAR(40) NOT NULL,
    castka INTEGER NOT NULL
);
ALTER TABLE adopce ADD CONSTRAINT pk_adopce PRIMARY KEY (id_adopce);
ALTER TABLE adopce ADD CONSTRAINT u_fk_adopce_zivocich UNIQUE (nazev);

CREATE TABLE adresa (
    id_adresa SERIAL NOT NULL,
    stat VARCHAR(40) NOT NULL,
    mesto VARCHAR(40) NOT NULL,
    ulice VARCHAR(40) NOT NULL,
    cislo INTEGER NOT NULL,
    psc INTEGER NOT NULL,
    cislo_bytu INTEGER
);
ALTER TABLE adresa ADD CONSTRAINT pk_adresa PRIMARY KEY (id_adresa);

CREATE TABLE akce (
    id_akce SERIAL NOT NULL,
    typ_akce VARCHAR(40) NOT NULL,
    cena INTEGER NOT NULL,
    datum_konani DATE NOT NULL
);
ALTER TABLE akce ADD CONSTRAINT pk_akce PRIMARY KEY (id_akce);

CREATE TABLE certifikat (
    id_adopce INTEGER NOT NULL,
    specialni_podekovani VARCHAR(256)
);
ALTER TABLE certifikat ADD CONSTRAINT pk_certifikat PRIMARY KEY (id_adopce);

CREATE TABLE pruvodce (
    id_pruvodce SERIAL NOT NULL,
    id_zamestnance INTEGER NOT NULL,
    plat INTEGER NOT NULL
);
ALTER TABLE pruvodce ADD CONSTRAINT pk_pruvodce PRIMARY KEY (id_pruvodce, id_zamestnance);
ALTER TABLE pruvodce ADD CONSTRAINT u_fk_pruvodce_zamestnanec UNIQUE (id_zamestnance);

CREATE TABLE rad (
    nazev VARCHAR(40) NOT NULL,
    procentualni_zastoupeni INTEGER NOT NULL
);
ALTER TABLE rad ADD CONSTRAINT pk_rad PRIMARY KEY (nazev);

CREATE TABLE typ (
    typ_akce VARCHAR(40) NOT NULL
);
ALTER TABLE typ ADD CONSTRAINT pk_typ PRIMARY KEY (typ_akce);

CREATE TABLE vyhlasky (
    id_vyhlasky SERIAL NOT NULL,
    id_zamestnance INTEGER NOT NULL,
    zivocich VARCHAR(40) NOT NULL,
    lokace VARCHAR(40) NOT NULL,
    duvod VARCHAR(256)
);
ALTER TABLE vyhlasky ADD CONSTRAINT pk_vyhlasky PRIMARY KEY (id_vyhlasky);

CREATE TABLE zakaznik (
    id_zakaznik SERIAL NOT NULL,
    id_adresa INTEGER NOT NULL,
    jmeno VARCHAR(40) NOT NULL,
    prijmeni VARCHAR(40) NOT NULL,
    datum_narozeni DATE
);
ALTER TABLE zakaznik ADD CONSTRAINT pk_zakaznik PRIMARY KEY (id_zakaznik);
ALTER TABLE zakaznik ADD CONSTRAINT u_fk_zakaznik_adresa UNIQUE (id_adresa);

CREATE TABLE zamestnanec (
    id_zamestnance SERIAL NOT NULL,
    id_adresa INTEGER NOT NULL,
    zamestnanec_id_zamestnance INTEGER,
    jmeno VARCHAR(40) NOT NULL,
    prijmeni VARCHAR(40) NOT NULL,
    plat INTEGER NOT NULL,
    datum_narozeni DATE
);
ALTER TABLE zamestnanec ADD CONSTRAINT pk_zamestnanec PRIMARY KEY (id_zamestnance);
ALTER TABLE zamestnanec ADD CONSTRAINT u_fk_zamestnanec_adresa UNIQUE (id_adresa);

CREATE TABLE zivocich (
    nazev VARCHAR(40) NOT NULL,
    rad_nazev VARCHAR(40) NOT NULL,
    potrava VARCHAR(256) NOT NULL,
    ohrozenost VARCHAR(40) NOT NULL,
    latinsky_nazev VARCHAR(40)
);
ALTER TABLE zivocich ADD CONSTRAINT pk_zivocich PRIMARY KEY (nazev);

CREATE TABLE pruvodce_akce (
    id_pruvodce INTEGER NOT NULL,
    id_zamestnance INTEGER NOT NULL,
    id_akce INTEGER NOT NULL
);
ALTER TABLE pruvodce_akce ADD CONSTRAINT pk_pruvodce_akce PRIMARY KEY (id_pruvodce, id_zamestnance, id_akce);

CREATE TABLE zakaznik_akce (
    id_zakaznik INTEGER NOT NULL,
    id_akce INTEGER NOT NULL
);
ALTER TABLE zakaznik_akce ADD CONSTRAINT pk_zakaznik_akce PRIMARY KEY (id_zakaznik, id_akce);

ALTER TABLE adopce ADD CONSTRAINT fk_adopce_zakaznik FOREIGN KEY (id_zakaznik) REFERENCES zakaznik (id_zakaznik) ON DELETE CASCADE;
ALTER TABLE adopce ADD CONSTRAINT fk_adopce_zivocich FOREIGN KEY (nazev) REFERENCES zivocich (nazev) ON DELETE CASCADE;

ALTER TABLE akce ADD CONSTRAINT fk_akce_typ FOREIGN KEY (typ_akce) REFERENCES typ (typ_akce) ON DELETE CASCADE;

ALTER TABLE certifikat ADD CONSTRAINT fk_certifikat_adopce FOREIGN KEY (id_adopce) REFERENCES adopce (id_adopce) ON DELETE CASCADE;

ALTER TABLE pruvodce ADD CONSTRAINT fk_pruvodce_zamestnanec FOREIGN KEY (id_zamestnance) REFERENCES zamestnanec (id_zamestnance) ON DELETE CASCADE;

ALTER TABLE vyhlasky ADD CONSTRAINT fk_vyhlasky_zamestnanec FOREIGN KEY (id_zamestnance) REFERENCES zamestnanec (id_zamestnance) ON DELETE CASCADE;

ALTER TABLE zakaznik ADD CONSTRAINT fk_zakaznik_adresa FOREIGN KEY (id_adresa) REFERENCES adresa (id_adresa) ON DELETE CASCADE;

ALTER TABLE zamestnanec ADD CONSTRAINT fk_zamestnanec_adresa FOREIGN KEY (id_adresa) REFERENCES adresa (id_adresa) ON DELETE CASCADE;
ALTER TABLE zamestnanec ADD CONSTRAINT fk_zamestnanec_zamestnanec FOREIGN KEY (zamestnanec_id_zamestnance) REFERENCES zamestnanec (id_zamestnance) ON DELETE CASCADE;

ALTER TABLE zivocich ADD CONSTRAINT fk_zivocich_rad FOREIGN KEY (rad_nazev) REFERENCES rad (nazev) ON DELETE CASCADE;

ALTER TABLE pruvodce_akce ADD CONSTRAINT fk_pruvodce_akce_pruvodce FOREIGN KEY (id_pruvodce, id_zamestnance) REFERENCES pruvodce (id_pruvodce, id_zamestnance) ON DELETE CASCADE;
ALTER TABLE pruvodce_akce ADD CONSTRAINT fk_pruvodce_akce_akce FOREIGN KEY (id_akce) REFERENCES akce (id_akce) ON DELETE CASCADE;

ALTER TABLE zakaznik_akce ADD CONSTRAINT fk_zakaznik_akce_zakaznik FOREIGN KEY (id_zakaznik) REFERENCES zakaznik (id_zakaznik) ON DELETE CASCADE;
ALTER TABLE zakaznik_akce ADD CONSTRAINT fk_zakaznik_akce_akce FOREIGN KEY (id_akce) REFERENCES akce (id_akce) ON DELETE CASCADE;

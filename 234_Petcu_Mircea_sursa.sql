create sequence sala_fitness_seq
    increment by 1
    start with 10;
drop sequence sala_fitness_seq;
--creare tabele

--4
create table ADRESE
(
    id_adresa  number(6)
        constraint pk_adresa primary key,
    cod_postal varchar2(10),
    strada     varchar2(40),
    numar      varchar2(5),
    oras       varchar2(50),
    tara       varchar2(50)
);

create table SALI_DE_FITNESS
(
    id_sala   number(6)
        constraint pk_sala primary key,
    denumire  varchar2(50),
    email     varchar2(50)
        constraint nn_sala_email not null,
    telefon   varchar2(10)
        constraint unq_sala_tel unique,
    id_adresa number(6),
    constraint fk_sali_locatii foreign key (id_adresa)
        references ADRESE (id_adresa) on delete cascade,
    constraint unq_sali_email unique (email)
);

create table DEPARTAMENTE
(
    id_departament number(6)
        constraint pk_dep primary key,
    denumire       varchar2(50)
);
alter table DEPARTAMENTE
    add buget number(10, 2);

create table MESERII
(
    id_meserie number(6)
        constraint pk_meserie primary key,
    meserie    varchar2(50),
    constraint unq_meserii unique (meserie)
);
alter table MESERII
    add salariu_maxim number(10);
create table ANGAJATI
(
    id_angajat     number(6)
        constraint pk_ang primary key,
    nume           varchar2(50)
        constraint nn_ang_nume not null,
    prenume        varchar2(50),
    email          varchar2(50)
        constraint nn_ang_email not null,
    salariu        number(7) default 1500,
    id_departament number(6),
    id_meserie     number(6),
    id_sala        number(6),
    constraint fk_ang_dep foreign key (id_departament)
        references DEPARTAMENTE (id_departament) on delete cascade,
    constraint unq_ang_email unique (email),
    constraint chk_ang_sal check ( salariu > 1399 ),
    constraint fk_ang_meserii foreign key (id_meserie)
        references MESERII (id_meserie) on delete cascade,
    constraint fk_ang_sali foreign key (id_sala)
        references SALI_DE_FITNESS (id_sala) on delete cascade
);

create table GAME_APARATE
(
    id_gama_aparate number(6)
        constraint pk_game_aparate primary key,
    firma           varchar2(50),
    data_productie  date,
    id_sala         number(6),
    constraint fk_game_aparate_sali foreign key (id_sala)
        references SALI_DE_FITNESS (id_sala) on delete cascade
);
drop table APARATE_FITNESS;
drop table GAME_APARATE;
create table GAME_SUPLIMENTE
(
    id_gama_suplimente number(6)
        constraint pk_game_suplimente primary key,
    firma              varchar2(50),
    id_sala            number(6),
    constraint fk_game_suplimente_sali foreign key (id_sala)
        references SALI_DE_FITNESS (id_sala) on delete cascade
);

create table APARATE_FITNESS
(
    id_aparat       number(6)
        constraint pk_aparate primary key,
    grupa_musculara varchar2(50),
    denumire        varchar2(50),
    id_gama_aparate number(6),
    constraint fk_aparate_fitness_sali foreign key (id_gama_aparate)
        references GAME_APARATE (id_gama_aparate) on delete cascade
);

create table SUPLIMENTE
(
    id_supliment       number(6)
        constraint pk_suplimente primary key,
    denumire           varchar2(50),
    id_gama_suplimente number(6),
    constraint fk_suplimente_sali foreign key (id_gama_suplimente)
        references GAME_SUPLIMENTE (id_gama_suplimente) on delete cascade
);

create table CLIENTI
(
    id_client number(6)
        constraint pk_clienti primary key,
    nume      varchar2(50)
        constraint nn_nume_clienti not null,
    prenume   varchar2(50),
    email     varchar2(50)
        constraint nn_email_clienti not null,
    constraint unq_email_clienti unique (email)
);

create table ABONAMENTE
(
    id_abonament   number(6)
        constraint pk_abonamente primary key,
    data_incepere  date
        constraint nn_incepre not null,
    data_terminare date
        constraint nn_terminare not null,
    aerobic        varchar2(2),
    id_client      number(6)
        constraint nn_id_client not null,
    constraint fk_abonamente_clienti foreign key (id_client)
        references CLIENTI (id_client) on delete cascade
);

create table SE_ANTRENEAZA
(
    id_client number(6),
    id_sala   number(6),
    constraint pk_se_antreneaza primary key (id_client, id_sala),
    constraint fk_se_antreneaza_1 foreign key (id_client)
        references CLIENTI (id_client) on delete cascade,
    constraint fk_se_antreneaza_2 foreign key (id_sala)
        references SALI_DE_FITNESS (id_sala) on delete cascade
);
create table RAPOARTE_FINANCIARE
(
    id_sala    number(6),
    an         number(4),
    incasari   number(10, 2),
    cheltuieli number(10, 2),
    constraint pk_rap primary key (an, id_sala),
    constraint fk_rap_sala foreign key (id_sala)
        references SALI_DE_FITNESS (id_sala) on delete cascade
);
commit;

--inserare in tabele
--5
------------------------adrese------------------------------
insert into ADRESE
values (sala_fitness_seq.nextval, '1111', 'Calea 13 Septembrie', '95', 'Bucuresti', 23);
insert into ADRESE
values (sala_fitness_seq.nextval, '1112', 'Theodor Pallady', '200', 'Bucuresti', 23);
insert into ADRESE
values (sala_fitness_seq.nextval, '1113', 'Drumul Osiei', '2', 'Bucuresti', 23);
insert into ADRESE
values (sala_fitness_seq.nextval, '1114', 'Bulevardul Lapusneanu', '96', 'Constanta', 23);
insert into ADRESE
values (sala_fitness_seq.nextval, '1115', 'General Danail Nikolaev', '12', 'Sofia', 24);
select *
from ADRESE;

------------------------sali_de_fitness---------------------------------
insert into SALI_DE_FITNESS
values (sala_fitness_seq.nextval, 'Spartan Gym 13 Septembrie', 'spartan@13sept.ro', '0736592600', 10);
insert into SALI_DE_FITNESS
values (sala_fitness_seq.nextval, 'Spartan Gym Pallady', 'spartan@plldy.ro', '0736592601', 11);
insert into SALI_DE_FITNESS
values (sala_fitness_seq.nextval, 'Spartan Gym 13 Osiei', 'spartan@osiei.ro', '0736592602', 12);
insert into SALI_DE_FITNESS
values (sala_fitness_seq.nextval, 'Spartan Gym 13 Lapusneanu', 'spartan@lpn.ro', '0736592603', 13);
insert into SALI_DE_FITNESS
values (sala_fitness_seq.nextval, 'Spartan Gym 13 Nikolaev', 'spartan@nik.ro', '0736592604', 14);

select *
from SALI_DE_FITNESS;

-- drop table ADRESE;
-- drop table APARATE_FITNESS;
-- drop table SUPLIMENTE;
-- drop table GAME_SUPLIMENTE;
-- drop table GAME_APARATE;
-- drop table SE_ANTRENEAZA;
-- drop table ABONAMENTE;
-- drop table CLIENTI;
-- drop table ANGAJATI;
-- drop table DEPARTAMENTE;
-- drop table SALI_DE_FITNESS;
-- drop table RAPOARTE_FINANCIARE;

--------------------------departamente----------------------
insert into DEPARTAMENTE
values (sala_fitness_seq.nextval, 'Instructori');
insert into DEPARTAMENTE
values (sala_fitness_seq.nextval, 'Directorat');
insert into DEPARTAMENTE
values (sala_fitness_seq.nextval, 'Curatenie');
insert into DEPARTAMENTE
values (sala_fitness_seq.nextval, 'Receptie');
insert into DEPARTAMENTE
values (sala_fitness_seq.nextval, 'Contabilitate');

select *
from DEPARTAMENTE;
declare
    nr     number := 100000;
    ordine number := 120;
begin
    while ordine < 125
        loop
            update DEPARTAMENTE
            set buget = nr
            where id_departament = ordine;
            ordine := ordine + 1;
            nr := nr - 1000;
        end loop;
end;

---------------meserii------------------------
insert into MESERII
values (sala_fitness_seq.nextval, 'Director Sef Principal');
insert into MESERII
values (sala_fitness_seq.nextval, 'Director Sef');
insert into MESERII
values (sala_fitness_seq.nextval, 'Director Adjunct');
insert into MESERII
values (sala_fitness_seq.nextval, 'Om de serviciu sef');
insert into MESERII
values (sala_fitness_seq.nextval, 'Om de serviciu');
insert into MESERII
values (sala_fitness_seq.nextval, 'Receptioner sef');
insert into MESERII
values (sala_fitness_seq.nextval, 'Receptioner');
insert into MESERII
values (sala_fitness_seq.nextval, 'Instructor sef');
insert into MESERII
values (sala_fitness_seq.nextval, 'Instructor');
insert into MESERII
values (sala_fitness_seq.nextval, 'Contabil');
alter table MESERII
    drop column salariu_maxim;
select *
from MESERII;
declare
    ordine number := 125;
    nr     number := 1000001;
begin
    while ordine < 135
        loop
            update MESERII
            set salariu_maxim = nr
            where id_meserie = ordine;
            if ordine < 130 then
                nr := nr - 100000;
            end if;
            ordine := ordine + 1;
        end loop;
end;
/

---------------angajati-----------------------
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Petcu', 'Mircea', 'mp2002@gmail.com', 1000000, 121, 125, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Ionescu', 'Marcel', 'im@gmail.ro', 100000, 121, 127, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Ion', 'Ana', 'ia@gmail.ro', 10000, 122, 128, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Bon', 'Ana', 'ba2@gmail.ro', 2000, 122, 129, 17);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Bonescu', 'Marcela', 'bm@gmail.ro', 2000, 123, 130, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Pop', 'Ana', 'pa@gmail.ro', 2000, 123, 133, 18);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Ion', 'Scaun', 'is@gmail.ro', 20000, 124, 132, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Scarlet', 'Mircea', 'sm@gmail.ro', 15000, 124, 133, 16);

insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Pletos ', 'Ion', 'pi@gmail.com', 200000, 121, 126, 17);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Mirel', 'Marcel', 'mm@gmail.ro', 100000, 124, 134, 16);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Ana', 'Ana', 'aa@gmail.ro', 10000, 122, 129, 19);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Con', 'Ana', 'ca@gmail.ro', 2000, 123, 131, 19);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Conescu', 'Marcela', 'cm@gmail.ro', 2000, 123, 131, 20);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Popescu', 'Hartie', 'ph@gmail.ro', 2000, 120, 133, 19);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Bon', 'Scaun', 'bs@gmail.ro', 20000, 120, 133, 18);
insert into ANGAJATI
values (sala_fitness_seq.nextval, 'Ciutan', 'Mircea', 'cm2@gmail.ro', 15000, 120, 133, 20);

----------------------------rapoarte_financiare-------------------------------
select *
from SALI_DE_FITNESS;
insert into RAPOARTE_FINANCIARE
values (16, 2022, 10000000, 100000);
insert into RAPOARTE_FINANCIARE
values (16, 2021, 1000000, 100000);
insert into RAPOARTE_FINANCIARE
values (17, 2022, 30000000, 300000);
insert into RAPOARTE_FINANCIARE
values (18, 2022, 1000000, 10000);
insert into RAPOARTE_FINANCIARE
values (19, 2022, 20000000, 200000);
select *
from RAPOARTE_FINANCIARE;

----------------------------gama_aparate---------------------------------------
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Hammer Strength', to_date('10-10-2021', 'DD-MM-YYYY'), 16);
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Tehno Gym', to_date('10-10-2022', 'DD-MM-YYYY'), 16);
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Hammer Strength', to_date('10-10-2022', 'DD-MM-YYYY'), 17);
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Panaita', to_date('10-10-2021', 'DD-MM-YYYY'), 18);
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Cybex', to_date('10-10-2021', 'DD-MM-YYYY'), 19);
insert into GAME_APARATE
values (sala_fitness_seq.nextval, 'Hammer Strength', to_date('10-10-2021', 'DD-MM-YYYY'), 20);

----------------------------aparate_fitness------------------------------------
insert into APARATE_FITNESS
values (sala_fitness_seq.nextval, 'piept', 'presa la piept', 154);
insert into APARATE_FITNESS
values (sala_fitness_seq.nextval, 'picioare', 'presa la picioare', 154);
insert into APARATE_FITNESS
values (sala_fitness_seq.nextval, 'triceps', 'scripete', 155);
insert into APARATE_FITNESS
values (sala_fitness_seq.nextval, 'spate', 'low row', 156);
insert into APARATE_FITNESS
values (sala_fitness_seq.nextval, 'umeri', 'aparat fluturati umeri', 157);

----------------------------gama_suplimente---------------------------------------
insert into GAME_SUPLIMENTE
values (sala_fitness_seq.nextval, 'DY Nutrition', 16);
insert into GAME_SUPLIMENTE
values (sala_fitness_seq.nextval, 'MP', 17);
insert into GAME_SUPLIMENTE
values (sala_fitness_seq.nextval, 'MuscleTech', 18);
insert into GAME_SUPLIMENTE
values (sala_fitness_seq.nextval, 'GymBeam', 19);
insert into GAME_SUPLIMENTE
values (sala_fitness_seq.nextval, 'MP', 20);
select *
from GAME_SUPLIMENTE;

---------------------------------------suplimente--------------------------------
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Proteina', 165);
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Creatina', 165);
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Citrulina', 166);
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Beta-Alanina', 167);
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Proteina', 168);
insert into SUPLIMENTE
values (sala_fitness_seq.nextval, 'Creatina', 169);

-----------------------------clienti-------------------------------------
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Pecul', 'Mircea', 'mp2202@gmail.com');
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Tetul', 'Mircea', 'tp2202@gmail.com');
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Cecul', 'Mirel', 'cp2202@gmail.com');
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Alb', 'Marcek', 'ma2202@gmail.com');
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Qiu', 'Mircea', 'mq2202@gmail.com');
insert into CLIENTI
values (sala_fitness_seq.nextval, 'Ciutul', 'Andrei', 'ca2202@gmail.com');

select *
from CLIENTI
where id_client = 176;

-----------------------se_antreneaza----------------------------------
insert into SE_ANTRENEAZA
values (176, 16);
insert into SE_ANTRENEAZA
values (176, 17);
insert into SE_ANTRENEAZA
values (177, 17);
insert into SE_ANTRENEAZA
values (178, 18);
insert into SE_ANTRENEAZA
values (179, 19);
insert into SE_ANTRENEAZA
values (180, 16);
insert into SE_ANTRENEAZA
values (179, 16);
insert into SE_ANTRENEAZA
values (177, 19);
insert into SE_ANTRENEAZA
values (181, 20);
insert into SE_ANTRENEAZA
values (181, 18);
insert into SE_ANTRENEAZA
values (181, 19);
select *
from SE_ANTRENEAZA;

------------------------abonamente------------------------------
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'), 'Da', 176);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('10-11-2022', 'dd-mm-yyyy'), 'Da', 177);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('11-10-2022', 'dd-mm-yyyy'), to_date('11-11-2022', 'dd-mm-yyyy'), 'Da', 176);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('12-11-2022', 'dd-mm-yyyy'), 'Da', 178);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('13-10-2022', 'dd-mm-yyyy'), to_date('13-11-2022', 'dd-mm-yyyy'), 'Nu', 179);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('14-10-2022', 'dd-mm-yyyy'), to_date('14-11-2022', 'dd-mm-yyyy'), 'Da', 180);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('15-10-2022', 'dd-mm-yyyy'), to_date('15-11-2022', 'dd-mm-yyyy'), 'Nu', 181);
insert into ABONAMENTE
values (sala_fitness_seq.nextval, to_date('17-10-2022', 'dd-mm-yyyy'), to_date('17-11-2022', 'dd-mm-yyyy'), 'Da', 179);

commit;

--6
-- 6.Formulați în  limbaj  natural o problemă pe care să orezolvați
-- folosind unsubprogram  stocatindependent care să utilizeze douătipuridiferite
-- de colecțiistudiate. Apelați subprogramul.

-- Enunt: Mentineti intr-o colectie toti clientii al caror email se termina cu '.com'. In alta colectie mentineti abonamentel fiecarui dintre ei. Afisati
-- pentru fiecare client abonamentele sale, si nr de abonamente avute sub forma clientul si abonamentele.

create or replace procedure ex_6_mpe
    is
    type tab_index is table of CLIENTI%rowtype index by pls_integer;
    t  tab_index;
    type arr is varray(100) of ABONAMENTE%rowtype;
    v  arr    := arr();
    nr number := 0;
begin
    select * bulk collect
    into t
    from CLIENTI
    where email like ('%.com');
    for i in t.first..t.LAST
        loop
            DBMS_OUTPUT.PUT_LINE('clientul cu id-ul : ' || t(i).id_client || ' cu numele si prenumele: ' || t(i).nume ||
                                 ' ' || t(i).prenume || ' si emailul: ' || t(i).email);
            DBMS_OUTPUT.PUT_LINE('A avut/are abonamentele: ');
            DBMS_OUTPUT.NEW_LINE();
            select * bulk collect
            into v
            from ABONAMENTE
            where id_client = t(i).id_client;
            for i in v.first..v.last
                loop
                    DBMS_OUTPUT.PUT_LINE('abonamentul cu id-ul: ' || v(i).id_abonament || ' data incepere :' ||
                                         v(i).data_incepere || ' data terminare :' || v(i).data_terminare ||
                                         ' are aerobic: ' || v(i).aerobic);
                end loop;
            select count(*)
            into nr
            from ABONAMENTE
            where id_client = t(i).id_client;
            DBMS_OUTPUT.PUT_LINE('A avut: ' || nr || ' abonamente.');
            DBMS_OUTPUT.NEW_LINE();
        end loop;

end ex_6_mpe;
/

-- begin
--     DBMS_OUTPUT.ENABLE();
-- end;

begin
    ex_6_mpe;
end;
/
select *
from CLIENTI;
select *
from ABONAMENTE;

-- 7. Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind un subprogram  stocat
-- independent care să utilizeze 2 tipuri diferite de cursoare studiate,  unul  dintre  acestea
-- fiind  cursor parametrizat. Apelați subprogramul.

-- Enunt: Pentru fiecare sala de fitness ce se afla in Bucuresti gasiti gamele de aparate. Iar pentru fiecare gama
-- de aparate afisati aparatele de fitness(denumirea). Daca nu exista aparate in gama respectiva afisati mesajul: "Din
-- pacate nu are aparate din gama asta." .
create or replace procedure ex7_mpe
    is
    cursor c(id_gama GAME_APARATE.id_gama_aparate%type) is
        select denumire
        from APARATE_FITNESS
        where id_gama_aparate = id_gama;
    type t_denumiri is table of GAME_APARATE.firma%type;
    tden t_denumiri;
begin
    for i in (select distinct s.id_sala, s.denumire
              from SALI_DE_FITNESS s,
                   ADRESE a
              where s.id_adresa = a.id_adresa
                and a.oras = 'Bucuresti')
        loop
            DBMS_OUTPUT.PUT_LINE('Sala cu id-ul: ' || i.id_sala || '; si denumirea: ' || i.denumire ||
                                 '; are urmatoarele game de aparate: ');
            for k in (select id_gama_aparate, firma, data_productie
                      from GAME_APARATE
                      where id_sala = i.id_sala)
                loop
                    DBMS_OUTPUT.PUT_LINE('id: ' || k.id_gama_aparate || '; firma: ' || k.firma ||
                                         '; data productie: ' || k.data_productie ||
                                         '; cu aparatele urmatoare: ');
                    open c(k.id_gama_aparate);
                    fetch c bulk collect into tden;
                    loop
                        if tden.COUNT = 0 then
                            DBMS_OUTPUT.PUT_LINE('Din pacate nu are aparate din gama asta.');
                        else
                            for j in tden.FIRST..tden.LAST
                                loop
                                    DBMS_OUTPUT.PUT_LINE(' Aparat: ' || tden(j));
                                end loop;

                        end if;


                        exit when c%notfound;
                    end loop;
                    close c;
                end loop;
        end loop;
end ex7_mpe;
/

begin
    ex7_mpe;
end;
/

-- 8.Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind un subprogram  stocat
-- independent de tip funcție care să utilizeze într-o singură comandă SQL 3 dintre tabelele definite.
-- Definiți minim 2 excepții. Apelați subprogramul astfel încât să evidențiați toate cazurile tratate.

-- Enunt: Pentru clientul cu numele dat ca parametru afisati o sala in care se antreneaza. Tratati erorile no_data_found, too_many_rows plus cazul in
-- in care numele nu se da(' ') sau daca numele este 'mircea'.

create or replace function ex8_mpe(nume2 CLIENTI.nume%type)
    return varchar2
    is
    nume_invalid exception ;
    nume_interzis exception ;
    denumire SALI_DE_FITNESS.denumire%type;
begin
    if nume2 = ' ' then
        raise nume_invalid;
    end if;
    if lower(nume2) = 'mircea' then
        raise nume_interzis;
    end if;
    select *
    into denumire
    from (select s.denumire
          from CLIENTI c,
               SE_ANTRENEAZA sa,
               SALI_DE_FITNESS s
          where c.id_client = sa.id_client
            and sa.id_sala = s.id_sala
            and lower(c.nume) = lower(nume2))
    where ROWNUM < 2;
    return denumire;
exception
    when nume_invalid then
        RAISE_APPLICATION_ERROR(-20003,
                                'Numele este invalid.');
        return '';
    when nume_interzis then
        RAISE_APPLICATION_ERROR(-20004,
                                'Numele este interzis.');
        return '';
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Nu exista un client cu numele acesta sau nu merge la nicio sala.');
        return '';
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001,
                                'Confuzie. Sunt mai multi clienti cu acelasi nume.');
        return '';
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
        return '';

end ex8_mpe;
/


begin
    for i in (select nume from CLIENTI)
        loop
            DBMS_OUTPUT.PUT_LINE('Nume: ' || i.nume || '; Sala: ' || ex8_mpe(i.nume));
        end loop;

end;/

begin
    DBMS_OUTPUT.PUT_LINE('Nume: Ionescu; Sala: ' || ex8_mpe('Ionescu'));
end;/

begin
    DBMS_OUTPUT.PUT_LINE('Nume:  ; Sala: ' || ex8_mpe(' '));
end;/

begin
    DBMS_OUTPUT.PUT_LINE('Nume: mircea; Sala: ' || ex8_mpe('mircea'));
end;
/

-- 9.Formulați în  limbaj  natural o problemă pe care să o rezolvați folosind un subprogram  stocat independent
-- de tip procedură care să utilizeze într-o singură comandă SQL 5  dintre  tabelele definite.  Tratați  toate
-- excepțiile care  pot  apărea,  incluzând  excepțiile  NO_DATA_FOUND  și TOO_MANY_ROWS. Apelați subprogramul
-- astfel încât să evidențiați toate cazurile tratate.

--Enunt: Afisati numele, meseria si salariul angajatului cu cel mai mare salariu din departamentul de directorat
-- (daca exista) care lucreaza intr-o sala din Bucuresti. Tratati si cazul cand sunt mai multi angajati ce indeplinesc
-- conditiile data.

create or replace procedure ex_9_mpe
    is
    mes    MESERII.meserie%type;
    name   ANGAJATI.nume%type;
    salary ANGAJATI.salariu%type;
begin
    select ag.nume, m.meserie, ag.salariu
    into name,mes,salary
    from ADRESE a,
         SALI_DE_FITNESS s,
         ANGAJATI ag,
         DEPARTAMENTE d,
         MESERII m
    where a.id_adresa = s.id_adresa
      and s.id_sala = ag.id_sala
      and ag.id_departament = d.id_departament
      and ag.id_meserie = m.id_meserie
      and lower(d.denumire) = 'directorat'
      and lower(a.oras) = 'bucuresti'
      and ag.salariu = (select max(salariu)
                        from ANGAJATI,
                             DEPARTAMENTE
                        where ANGAJATI.id_departament = DEPARTAMENTE.id_departament
                          and lower(DEPARTAMENTE.denumire) = 'directorat');
    DBMS_OUTPUT.PUT_LINE(name || ' ' || mes || ' ' || salary);
exception
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajat care sa indeplineasca conditiile cerute.');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sunt mai mult de un angajat care sa indeplineasca conditiile cerute.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
end ex_9_mpe;
/
commit;

begin
    ex_9_mpe;
end;

-- 10.Definiți un triggerd e tip LMD la nivel de comandă. Declanșați trigger-ul.

create or replace trigger trigger10_mpe
    before update or delete
    on SALI_DE_FITNESS
declare
    type v_profit is varray(100) of number;
    vp     v_profit;
    eroare number := 0;
    triger_exception exception ;
begin
    select incasari - cheltuieli bulk collect
    into vp
    from RAPOARTE_FINANCIARE,
         SALI_DE_FITNESS s
    where s.id_sala = RAPOARTE_FINANCIARE.id_sala
      and RAPOARTE_FINANCIARE.an = extract(year from sysdate);
    for i in vp.first..vp.LAST
        loop
            if vp(i) < 0 then
                eroare := 1;
            end if;
        end loop;
    if eroare = 0 then
        raise triger_exception;
    end if;
exception
    when triger_exception then
        raise_application_error(-20001,
                                'Tabelul nu poate fi actualizat sau sters din el deoarece toate salile sunt pe profit in anul curent.');
end;
/

update SALI_DE_FITNESS
set denumire = 'Spartan Gym Osiei'
where id_sala =18;

select *
from SALI_DE_FITNESS;

-- 11.Definiți un triggerde tip LMD la nivel de linie.Declanșați trigger-ul.

create or replace procedure p11_aux_mpe(id_cl CLIENTI.id_client%type)
    is
begin
    update ABONAMENTE
    set data_terminare = data_terminare + 30
    where id_client = id_cl;
end;

create or replace trigger trigger11_mpe
    after update of prenume
    on CLIENTI
    for each row
declare
    ex1 exception ;
begin
    if lower(:NEW.prenume) = 'mircea'
    then
        raise ex1;
    end if;
    if lower(:NEW.prenume) = lower(:OLD.nume) then
        raise_application_error(-20002, 'prenumele nou este acelasi cu numele vechi.');
    end if;
    if updating then
        p11_aux_mpe(:OLD.id_client);
    end if;

exception

    when ex1 then
        raise_application_error(-20001, 'prenumele nu poate fi schimbat.');

end;
/


update CLIENTI
set prenume = 'mircea'
where id_client = 181;

rollback;

select *
from CLIENTI;



-- 12.Definiți un triggerde tip LDD. Declanșați trigger-ul.

create table actiuni_ulterioare
(
    id_actiune   number(6)
        constraint pk_1 primary key,
    utilizator   varchar2(50),
    baza_de_date varchar2(50),
    eveniment    varchar2(50),
    data_actiune date
);


create or replace trigger trigger12_mpe
    before create or drop or alter
    on database
begin
    insert into actiuni_ulterioare
    values (sala_fitness_seq.nextval, (select user from dual), Sys.DATABASE_NAME, sys.SYSEVENT, sysdate);
    DBMS_OUTPUT.PUT_LINE('Utilizatorul norocos: ' || USER);
end;
/

create table mir
(
    id_mir number
);
drop table mir;


select *
from actiuni_ulterioare;

commit;



-- 14.Definiți un pachet care să includă tipuri de date complexe și obiecte necesare unui  flux
--     de acțiuni integrate, specifice bazei de date definite (minim 2 tipuri de date, minim 2funcții,
--     minim 2 proceduri).


create or replace package pachet14_mpe is
    type t_clienti_sala is table of clienti.nume%type;
    type v_top5angajati is varray(5) of angajati.id_angajat%type;
    --returneaza ce profit a avut sala primita ca parametru in anul dat ca parametru, daca exista un raport
    function f1_14_mpe(sala_id SALI_DE_FITNESS.id_sala%type, anul RAPOARTE_FINANCIARE.an%type)
        return number;
    --returneaza numarul de clienti ai salii date ca parametru
    function f2_14_mpe(sala SALI_DE_FITNESS.id_sala%type) return number;
    --afisesaza toti instructorii salii dati ca parametru
    procedure p1_14_mpe(sala SALI_DE_FITNESS.id_sala%type);
    --afiseaza daca angajatul dat ca parametru castiga mai mult sau nu decat bugetul maxim pentru departamentul sau
    procedure p2_14_mpe(angajat ANGAJATI.id_angajat%type);
    --afiseaza top 5(daca exista cei mai bine platiti angajati)
    procedure p3_14_mpe(sala SALI_DE_FITNESS.id_sala%type);
    --afiseaza numele clientilor salii date ca parametru
    procedure p4_14_mpe(sala SALI_DE_FITNESS.id_sala%type);
end pachet14_mpe;

create or replace package body pachet14_mpe is
    top5angajati v_top5angajati := v_top5angajati();
    clienti_sala t_clienti_sala := t_clienti_sala();

    procedure p4_14_mpe(sala SALI_DE_FITNESS.id_sala%type) is
    begin

        select c.nume bulk collect
        into clienti_sala
        from SE_ANTRENEAZA sa,
             SALI_DE_FITNESS s,
             CLIENTI c
        where sa.id_client = c.id_client
          and sa.id_sala = s.id_sala
          and s.id_sala = sala;
        for i in clienti_sala.first..clienti_sala.LAST
            loop
                DBMS_OUTPUT.PUT_LINE(clienti_sala(i));

            end loop;
    exception
        when no_data_found then
            raise_application_error(-20008, 'Niciun angajat!');
    end p4_14_mpe;

    procedure p3_14_mpe(sala SALI_DE_FITNESS.id_sala%type)
    as
        sal ANGAJATI.salariu%type;
    begin
        select * bulk collect
        into top5angajati
        from (select ANGAJATI.id_angajat
              from ANGAJATI,
                   SALI_DE_FITNESS
              where ANGAJATI.id_sala = SALI_DE_FITNESS.id_sala
                and ANGAJATI.id_sala = sala
              order by salariu desc)
        where ROWNUM <= 5;
        for i in top5angajati.first..top5angajati.LAST
            loop
                select salariu
                into sal
                from ANGAJATI
                where id_angajat = top5angajati(i);
                DBMS_OUTPUT.PUT_LINE('Angajatul cu id-ul: ' || top5angajati(i) || ' cu salariul: ' || sal);
            end loop;
    exception
        when no_data_found then
            raise_application_error(-20009, 'Niciun angajat!');
    end p3_14_mpe;

    function f1_14_mpe(sala_id SALI_DE_FITNESS.id_sala%type, anul RAPOARTE_FINANCIARE.an%type)
        return number is
        profit number := 0;
    begin
        select (incasari - RAPOARTE_FINANCIARE.cheltuieli)
        into profit
        from RAPOARTE_FINANCIARE
        where id_sala = sala_id
          and an = anul;
        if profit >= 0 then
            return 1;
        else
            return 0;
        end if;
    exception
        when no_data_found then
            raise_application_error(-200001, 'Nu exista un raport pentru sala respectiva in anul respectiv.');
            return -1;
    end f1_14_mpe;

    procedure p2_14_mpe(angajat ANGAJATI.id_angajat%type)
        is
        nr number := 0;
    begin
        select (salariu - d.BUGET)
        into nr
        from ANGAJATI,
             DEPARTAMENTE d
        where ANGAJATI.id_departament = d.id_departament
          and angajat = id_angajat;
        if nr < 0 then
            DBMS_OUTPUT.PUT_LINE('ANGAJATUL CASTIGA PREA MULT');
        else
            DBMS_OUTPUT.PUT_LINE('ANGAJATUL CASTIGA CAT TREBUIE');
        end if;
    end p2_14_mpe;


    procedure p1_14_mpe(sala SALI_DE_FITNESS.id_sala%type) is
        type instructori is table of Angajati.id_angajat%type;
        instr instructori := instructori();
        n     ANGAJATI.nume%type;
        p     ANGAJATI.prenume%type;
        cursor c(ang ANGAJATI.id_angajat%type) is
            select nume, prenume
            from ANGAJATI
            where id_angajat = ang;
    begin
        select a.id_angajat bulk collect
        into instr
        from ANGAJATI a,
             MESERII m
        where a.id_sala = sala
          and a.id_meserie = m.id_meserie
          and lower(m.meserie) = lower('instructor');
        if instr.COUNT <> 0 then
            DBMS_OUTPUT.PUT_LINE('Instructori: ');
            for i in instr.FIRST..instr.LAST
                loop
                    open c(instr(i));
                    fetch c into n,p;
                    DBMS_OUTPUT.PUT_LINE(n || ' ' || p);
                    exit when c%notfound;
                    close c;
                end loop;
        else
            DBMS_OUTPUT.PUT_LINE('Nu exista instructori la sala respectiva');
        end if;
    end p1_14_mpe;

    function
        f2_14_mpe(sala SALI_DE_FITNESS.id_sala%type)
        return number
        is
        nr_clienti number := 0;
        nume_sala  SALI_DE_FITNESS.denumire%type;
    begin
        select count(*)
        into nr_clienti
        from SE_ANTRENEAZA
        where id_sala = sala;
        select denumire
        into nume_sala
        from SALI_DE_FITNESS
        where id_sala = sala;
        DBMS_OUTPUT.PUT_LINE('Sala ' || nume_sala || ' are ' || nr_clienti || ' clienti');
        return nr_clienti;
    end f2_14_mpe;
end pachet14_mpe;


--testare
begin
    pachet14_mpe.P2_14_MPE(135);
    if pachet14_mpe.f1_14_mpe(18, 2022) = 1 then
        DBMS_OUTPUT.PUT_LINE('da');
    else
        DBMS_OUTPUT.PUT_LINE('nu');
    end if;
    DBMS_OUTPUT.PUT_LINE(pachet14_mpe.F2_14_MPE(16));
    pachet14_mpe.p1_14_mpe(18);
    pachet14_mpe.P3_14_MPE(16);
    pachet14_mpe.p4_14_mpe(16);
end;

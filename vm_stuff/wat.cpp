#include <iostream>
#include <cstdint>

int main() {
        typedef struct sa {
        int8_t _;
    } sa_t;

    typedef struct sb {
        int8_t  _;
        int32_t __;
    } sb_t;

    typedef struct sc {
        int32_t _;
        int8_t  __;
    } sc_t;

    typedef int8_t sd_t[3];

    typedef union se {
        int32_t _;
        int8_t  __;
        int64_t ___;
    } se_t;

    typedef se_t* sf_t;

    typedef struct sg {
        sf_t   _;
        float __;
        se_t   ___;
        sc_t   ____;
    } sg_t;

    typedef se_t sh_t[37];

    typedef union si {
        sh_t _;
        sf_t __;
    } si_t;

#pragma pack(push, 1)
    typedef struct sj {
        int16_t __;
        int8_t   _;
    } sj_t;
#pragma pack()

    typedef struct jk  {
        sj_t _;
        si_t __;
    } __attribute__ ((aligned (1024))) sk_t;

#pragma pack(push, 1)
    typedef struct jl {
        sk_t _;
        si_t __;
    } sl_t;
#pragma pack()

        typedef struct sm {
        int8_t _;
        sj_t  __;
    } sm_t;

    typedef int8_t sn_t[73];

    typedef struct so {
        sn_t _;
    } so_t;

    typedef struct sp {
        so_t _;
        sj_t __;
        sm_t ___;
    } sp_t;

    typedef sp_t sq_t[13];

    typedef struct sr {
        int8_t  _;
        sq_t   __;
        int32_t ___;
        sp_t   ____;
        so_t   _____;
    } sr_t;

    typedef sp_t ss_t[39];

    typedef int8_t st_t[7];

    typedef st_t su_t[39];

    typedef struct sv {
        ss_t _;
        su_t __;
    } sv_t;

    typedef sr_t sw_t[73];

    typedef struct sx {
        st_t   _;
        int16_t __;
    } sx_t;

    typedef sx_t sy_t[39];

    typedef struct sz {
        sv_t _;
        sr_t __;
        sy_t ___;
    } sz_t;

    typedef union s1 {
        int32_t _;
        double __;
        sz_t   ___;
    } s1_t;

    typedef struct s2 {
        s1_t _;
    } s2_t;

    typedef struct s3 {
        so_t _;
        sj_t __;
        sr_t ___;
    } s3_t;

    typedef union s4 {
        sm_t _;
        s3_t __;
        sp_t ___;
        sr_t ____;
        sz_t _____;
    } s4_t;

    typedef struct s5 {
        s4_t _;
        so_t __;
        sp_t ___;
        sr_t ____;
        s2_t _____;
    } s5_t;

    typedef so_t s6_t[902];

    typedef union s7 {
        sj_t _;
        s6_t __;
        sr_t ___;
    } s7_t;

    typedef sp_t s8_t[39];

    typedef struct s9 {
        s5_t _;
        s8_t __;
        s7_t ___;
    } s9_t;

    typedef s7_t s10_t[32];

    typedef s9_t s11_t[50];

    typedef s7_t s12_t[39];

    typedef union s13 {
        s11_t _;
        s12_t __;
    } s13_t;

    typedef struct s14 {
        s10_t _;
        s13_t __;
    } __attribute__ ((aligned (1024))) s14_t;

    typedef int8_t s15_t;

    typedef sj_t  s16_t[1];

    typedef sm_t  s17_t[2];

    typedef sn_t  s18_t[3];

    typedef sp_t  s19_t[4];

    typedef sr_t  s20_t[5];

    typedef sz_t  s21_t[6];

    typedef s2_t  s22_t[7];

    typedef s4_t  s23_t[8];

    typedef s5_t  s24_t[9];

    typedef s7_t  s25_t[10];

    typedef s9_t  s26_t[11];

    typedef s14_t s27_t[12];

#pragma pack(push, 1)
    typedef struct s28 {
        /*
            sj  -> a
            sm  -> b
            so  -> c
            sp  -> d
            sr  -> e
            sz  -> f
            s2  -> g
            s4  -> h
            s5  -> i
            s7  -> j
            s9  -> k
            s14 -> l
        */
        s16_t  _;
        s17_t  __;
        s18_t  ___;
        s19_t  ____;
        s20_t  _____;
        s21_t  ______;
        s22_t  _______;
        s23_t  ________;
        s24_t  _________;
        s25_t  __________;
        s26_t  ___________;
        s27_t ____________;
    } __attribute__ ((aligned (4096))) s28_t;
#pragma pack()

    std::cout << sizeof(s28_t) << std::endl;
    std::cout << alignof(s28_t) << std::endl;

}

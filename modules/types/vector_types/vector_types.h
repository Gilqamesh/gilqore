#ifndef VECTOR_TYPES_H
# define VECTOR_TYPES_H

# include "vector_types_defs.h"

/*
    v<number of elements><type> := <V>

    pack
    <V>_t <V>_p(n params of <type>);

    unpack
    void <V>_u(<V>_t* self, n params of <type*>);

    getters
    <type> <V>__g1(<V>_t* self);
    <type> <V>__g2(<V>_t* self);
    ...
    <type> <V>__gn(<V>_t* self);

    setters
    void <V>__s1(<V>_t* self, <type> a);
    void <V>__s2(<V>_t* self, <type> a);
    ...
    void <V>__sn(<V>_t* self, <type> a);

    broadcast (apply to each element) operations
    <V>_t <V>__bc_mul_<type>(<V>_t self, <type> a); // not protected against overflow
    <V>_t <V>__bc_add_<type>(<V>_t self, <type> a);
    <V>_t <V>__bc_sub_<type>(<V>_t self, <type> a);
    <V>_t <V>__bc_div_<type>(<V>_t self, <type> a);
    <V>_t <V>__bc_mod_<type>(<V>_t self, <type> a); // elements of the resulting vector are all positive
    <V>_t <V>__bc_abs_<type>(<V>_t self, <type> a);

    // TODO(david): what's the api here
    <V>_t <V>__bc_mask_<type>(<V>_t self, <V>_t self); // only

    // operations between vectors
    <V>_t  <V>__hadamard(<V>_t self, <V>_t other);
    <V>_t  <V>__dist    (<V>_t self, <V>_t other);
    <type> <V>__inner   (<V>_t self, <V>_t other);
    <V>_t  <V>__outer   (<V>_t self, <V>_t other);
    bool   <V>__eq      (<V>_t self, <V>_t other);

    // operation on self
    <V>_t <V>__normalize(<V>_t self);
*/

// types

typedef struct v2r32 { r32 a; r32 b; } v2r32_t;
typedef struct v2r64 { r64 a; r64 b; } v2r64_t;
typedef struct v2u8  { u8  a;  u8 b; } v2u8_t;
typedef struct v2u16 { u16 a; u16 b; } v2u16_t;
typedef struct v2u32 { u32 a; u32 b; } v2u32_t;
typedef struct v2u64 { u64 a; u64 b; } v2u64_t;
typedef struct v2s8  { s8  a; s8  b; } v2s8_t;
typedef struct v2s16 { s16 a; s16 b; } v2s16_t;
typedef struct v2s32 { s32 a; s32 b; } v2s32_t;
typedef struct v2s64 { s64 a; s64 b; } v2s64_t;

typedef struct v3r32 { r32 a; r32 b; r32 c; } v3r32_t;
typedef struct v3r64 { r64 a; r64 b; r64 c; } v3r64_t;
typedef struct v3u8  { u8  a;  u8 b; u8  c; } v3u8_t;
typedef struct v3u16 { u16 a; u16 b; u16 c; } v3u16_t;
typedef struct v3u32 { u32 a; u32 b; u32 c; } v3u32_t;
typedef struct v3u64 { u64 a; u64 b; u64 c; } v3u64_t;
typedef struct v3s8  { s8  a; s8  b; s8  c; } v3s8_t;
typedef struct v3s16 { s16 a; s16 b; s16 c; } v3s16_t;
typedef struct v3s32 { s32 a; s32 b; s32 c; } v3s32_t;
typedef struct v3s64 { s64 a; s64 b; s64 c; } v3s64_t;

typedef struct v4r32 { r32 a; r32 b; r32 c; r32 d; } v4r32_t;
typedef struct v4r64 { r64 a; r64 b; r64 c; r64 d; } v4r64_t;
typedef struct v4u8  { u8  a;  u8 b; u8  c; u8  d; } v4u8_t;
typedef struct v4u16 { u16 a; u16 b; u16 c; u16 d; } v4u16_t;
typedef struct v4u32 { u32 a; u32 b; u32 c; u32 d; } v4u32_t;
typedef struct v4u64 { u64 a; u64 b; u64 c; u64 d; } v4u64_t;
typedef struct v4s8  { s8  a; s8  b; s8  c; s8  d; } v4s8_t;
typedef struct v4s16 { s16 a; s16 b; s16 c; s16 d; } v4s16_t;
typedef struct v4s32 { s32 a; s32 b; s32 c; s32 d; } v4s32_t;
typedef struct v4s64 { s64 a; s64 b; s64 c; s64 d; } v4s64_t;

// pack

INLINE v2r32_t v2r32__p(r32 a, r32 b);
INLINE v2r64_t v2r64__p(r64 a, r64 b);
INLINE v2u8_t  v2u8__p (u8  a,  u8 b);
INLINE v2u16_t v2u16__p(u16 a, u16 b);
INLINE v2u32_t v2u32__p(u32 a, u32 b);
INLINE v2u64_t v2u64__p(u64 a, u64 b);
INLINE v2s8_t  v2s8__p (s8  a,  s8 b);
INLINE v2s16_t v2s16__p(s16 a, s16 b);
INLINE v2s32_t v2s32__p(s32 a, s32 b);
INLINE v2s64_t v2s64__p(s64 a, s64 b);

INLINE v3r32_t v3r32__p(r32 a, r32 b, r32 c);
INLINE v3r64_t v3r64__p(r64 a, r64 b, r64 c);
INLINE v3u8_t  v3u8__p (u8  a,  u8 b, u8  c);
INLINE v3u16_t v3u16__p(u16 a, u16 b, u16 c);
INLINE v3u32_t v3u32__p(u32 a, u32 b, u32 c);
INLINE v3u64_t v3u64__p(u64 a, u64 b, u64 c);
INLINE v3s8_t  v3s8__p (s8  a,  s8 b, s8  c);
INLINE v3s16_t v3s16__p(s16 a, s16 b, s16 c);
INLINE v3s32_t v3s32__p(s32 a, s32 b, s32 c);
INLINE v3s64_t v3s64__p(s64 a, s64 b, s64 c);

INLINE v4r32_t v4r32__p(r32 a, r32 b, r32 c, r32 d);
INLINE v4r64_t v4r64__p(r64 a, r64 b, r64 c, r64 d);
INLINE v4u8_t  v4u8__p (u8  a,  u8 b, u8  c, u8  d);
INLINE v4u16_t v4u16__p(u16 a, u16 b, u16 c, u16 d);
INLINE v4u32_t v4u32__p(u32 a, u32 b, u32 c, u32 d);
INLINE v4u64_t v4u64__p(u64 a, u64 b, u64 c, u64 d);
INLINE v4s8_t  v4s8__p (s8  a,  s8 b, s8  c, s8  d);
INLINE v4s16_t v4s16__p(s16 a, s16 b, s16 c, s16 d);
INLINE v4s32_t v4s32__p(s32 a, s32 b, s32 c, s32 d);
INLINE v4s64_t v4s64__p(s64 a, s64 b, s64 c, s64 d);

// unpack

INLINE void v2r32__u(v2r32* self, r32 a, r32 b);
INLINE void v2r64__u(v2r64* self, r64 a, r64 b);
INLINE void v2u8__u (v2u8* self,  u8  a,  u8 b);
INLINE void v2u16__u(v2u16* self, u16 a, u16 b);
INLINE void v2u32__u(v2u32* self, u32 a, u32 b);
INLINE void v2u64__u(v2u64* self, u64 a, u64 b);
INLINE void v2s8__u (v2s8* self,  s8  a,  s8 b);
INLINE void v2s16__u(v2s16* self, s16 a, s16 b);
INLINE void v2s32__u(v2s32* self, s32 a, s32 b);
INLINE void v2s64__u(v2s64* self, s64 a, s64 b);

INLINE void v3r32__u(v3r32_t* self, r32 a, r32 b, r32 c);
INLINE void v3r64__u(v3r64_t* self, r64 a, r64 b, r64 c);
INLINE void v3u8__u (v3u8_t* self,  u8  a,  u8 b, u8  c);
INLINE void v3u16__u(v3u16_t* self, u16 a, u16 b, u16 c);
INLINE void v3u32__u(v3u32_t* self, u32 a, u32 b, u32 c);
INLINE void v3u64__u(v3u64_t* self, u64 a, u64 b, u64 c);
INLINE void v3s8__u (v3s8_t* self,  s8  a,  s8 b, s8  c);
INLINE void v3s16__u(v3s16_t* self, s16 a, s16 b, s16 c);
INLINE void v3s32__u(v3s32_t* self, s32 a, s32 b, s32 c);
INLINE void v3s64__u(v3s64_t* self, s64 a, s64 b, s64 c);

INLINE void v4r32__u(v4r32_t* self, r32 a, r32 b, r32 c, r32 d);
INLINE void v4r64__u(v4r64_t* self, r64 a, r64 b, r64 c, r64 d);
INLINE void v4u8__u (v4u8_t* self,  u8  a,  u8 b, u8  c, u8  d);
INLINE void v4u16__u(v4u16_t* self, u16 a, u16 b, u16 c, u16 d);
INLINE void v4u32__u(v4u32_t* self, u32 a, u32 b, u32 c, u32 d);
INLINE void v4u64__u(v4u64_t* self, u64 a, u64 b, u64 c, u64 d);
INLINE void v4s8__u (v4s8_t* self,  s8  a,  s8 b, s8  c, s8  d);
INLINE void v4s16__u(v4s16_t* self, s16 a, s16 b, s16 c, s16 d);
INLINE void v4s32__u(v4s32_t* self, s32 a, s32 b, s32 c, s32 d);
INLINE void v4s64__u(v4s64_t* self, s64 a, s64 b, s64 c, s64 d);

// getters

INLINE r32 v2r32__g1(v2r32* self);
INLINE r32 v2r32__g2(v2r32* self);
INLINE r64 v2r64__g1(v2r64* self);
INLINE r64 v2r64__g2(v2r64* self);
INLINE u8  v2u8__g1 (v2u8* self);
INLINE u8  v2u8__g2 (v2u8* self);
INLINE u16 v2u16__g1(v2u16* self);
INLINE u16 v2u16__g2(v2u16* self);
INLINE u32 v2u32__g1(v2u32* self);
INLINE u32 v2u32__g2(v2u32* self);
INLINE u64 v2u64__g1(v2u64* self);
INLINE u64 v2u64__g2(v2u64* self);
INLINE s8  v2s8__g1 (v2s8* self);
INLINE s8  v2s8__g2 (v2s8* self);
INLINE s16 v2s16__g1(v2s16* self);
INLINE s16 v2s16__g2(v2s16* self);
INLINE s32 v2s32__g1(v2s32* self);
INLINE s32 v2s32__g2(v2s32* self);
INLINE s64 v2s64__g1(v2s64* self);
INLINE s64 v2s64__g2(v2s64* self);

INLINE r32 v3r32__s1(v3r32_t* self);
INLINE r64 v3r64__s1(v3r64_t* self);
INLINE u8  v3u8__s1 (v3u8_t* self);
INLINE u16 v3u16__s1(v3u16_t* self);
INLINE u32 v3u32__s1(v3u32_t* self);
INLINE u64 v3u64__s1(v3u64_t* self);
INLINE s8  v3s8__s1 (v3s8_t* self);
INLINE s16 v3s16__s1(v3s16_t* self);
INLINE s32 v3s32__s1(v3s32_t* self);
INLINE s64 v3s64__s1(v3s64_t* self);

#endif // VECTOR_TYPES_H

#include <iostream>
#include <set>
#include <vector>
#include <string>
#include <cstdio>
#include <cstdint>
#include <cASSERT>
#include <cstdlib>
#include <ctime>

// 8  for x86, ARM, and ARM64
// 16 for x64 native and ARM64EC
#define DEFAULT_MAX_ALIGNMENT (sizeof(void*) << 1)

static inline bool is_pow_of_two(uint64_t a) {
    if (a == 0) {
        return false;
}

    return (a & (a - 1)) == 0;
}

static inline uint64_t next_power_of_two(uint64_t a) {
    --a;

    a |= a >> 1;
    a |= a >> 2;
    a |= a >> 4;
    a |= a >> 8;
    a |= a >> 16;
    a |= a >> 32;

    ++a;

    return a;
}

using namespace std;

/*
    - alignment number is the biggest amongst all member's alignment, unless set to a higher number (cannot be set to lower)
    - address must be divisible by the alignment number
    - aligns each member to its alignment number
    - must be padded at the end so that the total size is divisible by the alignment number
*/
class type {
    string   _abbreviated_name;
    string   _full_name;
    string   _members_string;

    uint64_t _sizeof_total;
    uint64_t _alignment;
    uint64_t _address;
    uint64_t _max_alignment;

    struct member {
        uint64_t offset;
        type*    t;
    };
    std::vector<member> _members;
public:
    type(
        const std::vector<type*>& members,
        string abbreviated_name,
        string full_name,
        uint64_t alignment,
        uint64_t total_size
    ) {
        _sizeof_total = 0;
        _alignment = 0;
        _address = 0;
        _max_alignment = 0;

        for (uint32_t i = 0; i < members.size(); ++i) {
            _members.push_back({0, members[i]});
        }
        set_full_name(full_name);
        set_abbreviated_name(abbreviated_name);

        set_max_alignment((uint64_t)-1);
        set_address(rand());
        update_alignment(alignment);
        set_sizeof_total(total_size);

        update_members();
    }

    string members_string() {
        return _members_string;
    }
    void set_members_string(const string& members_string) {
        _members_string = members_string;
    }

    string full_name() {
        return _full_name;
    }
    virtual void set_full_name(const string& name){ 
        _full_name = name;
    }

    const string& abbreviated_name() const {
        return _abbreviated_name;
    }
    void set_abbreviated_name(const string& abbreviated_name) {
        _abbreviated_name = abbreviated_name;
    }

    uint64_t sizeof_total() {
        return _sizeof_total;
    }
    void set_sizeof_total(uint64_t sizeof_total) {
        _sizeof_total = sizeof_total;
    }

    uint64_t alignment() {
        return _alignment;
    }
    void set_alignment(uint64_t alignment) {
        if (alignment != -1) {
            ASSERT(is_pow_of_two(alignment));
        }

        _alignment = alignment;
        set_max_alignment((uint64_t)-1);
        // update_alignment(alignment);
        // update_members();
    }

    uint64_t address() const {
        return _address;
    }
    void set_address(uint64_t address) {
        _address = address;
    }

    uint64_t max_alignment() const {
        return _max_alignment;
    }
    void set_max_alignment(uint64_t max_alignment = DEFAULT_MAX_ALIGNMENT) {
        if (max_alignment != -1) {
            ASSERT(is_pow_of_two(max_alignment));
            ASSERT(max_alignment <= 16);
        }

        _max_alignment = max_alignment;

        update_members();
    }

private:
    void update_alignment(uint64_t alignment) {
        _alignment = min(_max_alignment, max(_alignment, alignment));
    }

    void update_members() {
        string result_full_name;
        for (uint32_t i = 0; i < _members.size(); ++i) {
            member m = _members[i];
            result_full_name += m.t->full_name();
            if (i < _members.size() - 1) {
                result_full_name += ", ";
            }
        }
        set_full_name(result_full_name);

        // alignment number is the biggest amongst all member's alignment
        for (uint32_t i = 0; i < _members.size(); ++i) {
            member m = _members[i];
            update_alignment(m.t->alignment());
        }

        // address must be divisible by the alignment number
        if (alignment()) {
            if (uint64_t r = address() % alignment()) {
                set_address(address() + (alignment() - r));
            }
            ASSERT(address() % alignment() == 0);
        }

        // align each member to its alignment number
        uint64_t offset = 0;
        for (uint32_t i = 0; i < _members.size(); ++i) {
            member& m = _members[i];

            // align member to its alignment number
            uint64_t s = 0;
            if (uint64_t r = offset % m.t->alignment()) {
                s = m.t->alignment() - r;
            } else {
                s = 0;
            }
            if (uint64_t r = offset % alignment()) {
                if (alignment() - r < s) {
                    s = alignment() - r;
                }
            } else {
                s = 0;
            }
            offset += s;

            // if (uint64_t r = offset % m.t->alignment()) {
            //     offset += m.t->alignment() - r;
            // }
            m.offset = offset;

            offset += m.t->sizeof_total();
        }

        // update own size
        if (offset) {
            set_sizeof_total(offset);
        }

        if (alignment()) {
            // must be padded at the end so that the total size is divisible by the alignment number
            if (uint64_t r = sizeof_total() % alignment()) {
                set_sizeof_total(sizeof_total() + (alignment() - r));
            }
        }
    }
};

class type_int8: public type {
public:
    type_int8(): type({}, "s8", "s8", sizeof(int8_t), sizeof(int8_t)) {}
};

class type_int16: public type {
public:
    type_int16(): type({}, "s16", "s16", sizeof(int16_t), sizeof(int16_t)) {}
};

class type_int32: public type {
public:
    type_int32(): type({}, "s32", "s32", sizeof(int32_t), sizeof(int32_t)) {}
};

class type_int64: public type {
public:
    type_int64(): type({}, "s64", "s64", sizeof(int64_t), sizeof(int64_t)) {}
};

class type_uint32: public type {
public:
    type_uint32(): type({}, "u32", "u32", sizeof(uint32_t), sizeof(uint32_t)) {}
};

class type_r32: public type {
public:
    type_r32(): type({}, "r32", "r32", sizeof(float), sizeof(float)) {}
};

class type_r64: public type {
public:
    type_r64(): type({}, "r64", "r64", sizeof(double), sizeof(double)) {}
};

class type_pointer: public type {
public:
    type_pointer(type* type_of_pointer): type({}, "p", "", sizeof(void*), sizeof(void*)) {
        set_full_name(type_of_pointer->full_name() + "p");
        set_abbreviated_name(type_of_pointer->abbreviated_name() + "p");
    }
};

class type_array: public type {
public:
    type_array(const string& abbreviated_name, type* t, uint32_t n): type({}, abbreviated_name, "", t->alignment(), n * t->sizeof_total()) {
        set_full_name("[" + to_string(n) + ", " + t->full_name() + "]");
    }
};

class type_struct: public type {
public:
    type_struct(const string& abbreviated_name, const vector<type*>& types): type(types, abbreviated_name, "", 0, 0) {
        set_members_string("{" + full_name() + "}");
    }
};

class type_union: public type {
    vector<type*> _members;
public:
    type_union(const string& abbreviated_name, const vector<type*> types): type({}, abbreviated_name, "", 0, 0), _members(types) {
        set_full_name("|" + full_name() + "|");

        uint64_t biggest_alignment = 0;
        type* biggest_type = NULL;
        for (type* t : types) {
            biggest_alignment = max(biggest_alignment, t->alignment());
            if (!biggest_type) {
                biggest_type = t;
            } else  if (t->sizeof_total() > biggest_type->sizeof_total()) {
                biggest_type = t;
            }
        }
        ASSERT(biggest_type);
        set_sizeof_total(biggest_type->sizeof_total());
        set_alignment(biggest_alignment);
    }
};

struct type_less {
    bool operator()(type* a, type* b) const {
        return a->abbreviated_name() < b->abbreviated_name();
    }
};

class types {
    set<type*, type_less> types;
public:
    void add(type* t) {
        types.insert(t);
    }
    void print_all(FILE* fp) {
        size_t max_abbreviated_name_len = 0;
        size_t max_type_total_size_len = 0;
        size_t max_address_len = 0;
        size_t max_alignment_len = 0;
        size_t max_pack_len = 0;
        size_t max_type_size_of_members_len = 0;
        size_t max_type_full_name_len = 0;
        for (auto& tp : types) {
            size_t abbreviated_name_len = tp->abbreviated_name().size();
            if (abbreviated_name_len > max_abbreviated_name_len) {
                max_abbreviated_name_len = abbreviated_name_len;
            }
            size_t type_total_size_len = to_string(tp->sizeof_total()).size();
            type_total_size_len = min(type_total_size_len, (size_t)64);
            if (type_total_size_len > max_type_total_size_len) {
                max_type_total_size_len = type_total_size_len;
            }
            size_t address_len = to_string(tp->address()).size();
            if (address_len > max_address_len) {
                max_address_len = address_len;
            }
            size_t alignment_len = to_string(tp->alignment()).size();
            alignment_len = min(alignment_len, (size_t)16);
            if (alignment_len > max_alignment_len) {
                max_alignment_len = alignment_len;
            }
            size_t pack_len = to_string(tp->max_alignment() == (uint64_t)-1 ? 0 : tp->max_alignment()).size();
            max_pack_len = max(max_pack_len, pack_len);
            type_struct* ts = dynamic_cast<type_struct*>(tp);
            type_union* tu = dynamic_cast<type_union*>(tp);
            size_t type_size_of_members_len = ts || tu ? tp->members_string().size() : 1;
            if (type_size_of_members_len > max_type_size_of_members_len) {
                max_type_size_of_members_len = type_size_of_members_len;
            }
            size_t type_full_name_len = tp->full_name().size();
            type_full_name_len = min(type_full_name_len, (size_t)32);
            if (type_full_name_len > max_type_full_name_len) {
                max_type_full_name_len = type_full_name_len;
            }
        }
        string abbreviated_name = "abbreviated name";
        string total_size = "total_size";
        string address = "address";
        string alignment = "alignment";
        string pack = "pack";
        string size_of_members = "size of members (s - size, o - offset)";
        string full_name = "full type name";
        size_t abbreviated_name_len = max(abbreviated_name.size(), max_abbreviated_name_len);
        size_t total_size_len = max(total_size.size(), max_type_total_size_len);
        size_t address_len = max(address.size(), max_address_len);
        size_t alignment_len = max(alignment.size(), max_alignment_len);
        size_t pack_len = max(pack.size(), max_pack_len);
        size_t size_of_members_len = max(size_of_members.size(), max_type_size_of_members_len);
        size_t full_name_len = max(full_name.size(), max_type_full_name_len);
        const char* format = "%*.*s    %*.*s    %*.*s    %*.*s    %*.*s    %*.*s    %*.*s\n";
        size_t format_len = abbreviated_name_len + total_size_len + address_len + alignment_len + pack_len + size_of_members_len + full_name_len + 16 /* n of spaces */;
        string types_str = "--== Types ==--";
        const char* types_format = "%*c%s%*c\n";
        fprintf(
            fp,
            types_format,
            (format_len - types_str.size()) / 2, ' ',
            types_str.c_str(),
            (format_len - types_str.size()) / 2, ' '
        );
        fprintf(fp, "%s\n", string(format_len, '_').c_str());
        fprintf(
            fp,
            format,
            abbreviated_name_len, abbreviated_name_len, abbreviated_name.c_str(),
            total_size_len, total_size_len, total_size.c_str(),
            address_len, address_len, address.c_str(),
            alignment_len, alignment_len, alignment.c_str(),
            pack_len, pack_len, pack.c_str(),
            size_of_members_len, size_of_members_len, size_of_members.c_str(),
            full_name_len, full_name_len, full_name.c_str()
        );
        for (auto& tp : types) {
            type_struct* ts = dynamic_cast<type_struct*>(tp);
            type_union* tu = dynamic_cast<type_union*>(tp);
            string type_size_of_members = ts || tu ? tp->members_string() : "-";
            fprintf(
                fp,
                format,
                abbreviated_name_len, abbreviated_name_len, tp->abbreviated_name().c_str(),
                total_size_len, total_size_len, to_string(tp->sizeof_total()).c_str(),
                address_len, address_len, to_string(tp->address()).c_str(),
                alignment_len, alignment_len, to_string(tp->alignment()).c_str(),
                pack_len, pack_len, tp->max_alignment() == (uint64_t)-1 ? "-" : to_string(tp->max_alignment()).c_str(),
                size_of_members_len, size_of_members_len, type_size_of_members.c_str(),
                full_name_len, full_name_len, tp->full_name().c_str()
            );
        }
    }
};

#define LOG(x) cout << #x ": " << x << endl

struct as {
    uint8_t  _;
    uint32_t __;
    uint32_t ___;
    char pad[20];
} __attribute__ ((aligned (32)));

struct bs {
    uint8_t _;
    uint16_t __;
    uint16_t ___;
};

// int main2() {
//     types t;

//     t.add(
//         new type_array(
//             "int32_int8_arr_of_2",
//             new type_struct("", {
//                 new type_int32(),
//                 new type_int8()
//             }),
//             2
//         )
//     );

//     t.add(new type_int16());
//     t.add(new type_int32());
//     t.add(new type_uint32());
//     t.add(new type_r32());
//     t.add(new type_r64());
//     t.add(new type_pointer(new type_r64()));

//     type_struct* int32_int8 = new type_struct("int32_int8", {
//         new type_int32(),
//         new type_int8()
//     });
//     t.add(int32_int8);

//     type_struct* int8_int32 = new type_struct("int8_int32", {
//         new type_int8(),
//         new type_int32()
//     });
//     t.add(int8_int32);

//     type_struct* int8_int32_int8 = new type_struct("int8_int32_int8", {
//         new type_int8(),
//         new type_int32(),
//         new type_int8()
//     });
//     t.add(int8_int32_int8);

//     type_struct* int8_int32__int8_int32_int8 = new type_struct("int8_int32__int8_int32_int8", {
//         int8_int32,
//         int8_int32_int8
//     });
//     t.add(int8_int32__int8_int32_int8);

//     type_array* int8_7 = new type_array(
//         "int8_7",
//         new type_int8(),
//         7
//     );
//     t.add(int8_7);

//     type_struct* int8_7__int16 = new type_struct("int8_7__int16", {
//         int8_7,
//         new type_int16()
//     });
//     t.add(int8_7__int16);

// #pragma pack(push)
// #pragma pack(1)
//     struct sa {
//         int  a;
//         char b; // pad extra 3
//     };
// #pragma pack(pop)

//     type_struct* ta = new type_struct("sa", {
//         new type_int32(),
//         new type_int8()
//     });
//     t.add(ta);
//     ta->set_max_alignment(1);

//     struct sb {
//         char   b;   // 1
//                     // 7 pad as _ needs to be on 8th byte <- NOT true
//                     // the biggest size of a type in a is 4, therefore it needs to sit on a 4-divisible byte
//                     // so 3 pad
//         sa     _; // sizeof(a) == 8
//                     // 12
//     };

//     type_struct* tb = new type_struct("sb", {
//         new type_int8(),
//         ta
//     });
//     t.add(tb);

//     struct sc {
//         char a[73];
//     };

//     type_array* tc = new type_array("sc", new type_int8(), 73);
//     t.add(tc);

//     struct sd {
//         sc _;    // [0-73)
//         sa __;   // [76-80 i32) [80-81 i8)
//         sb ___;  // [84-85 i8)  [88-92 i32) [92-93 i8) [93-96 pad)
//     };

//     vector<type*> _td = {
//         tc,
//         ta,
//         tb
//     };
//     type_struct* td = new type_struct("sd", _td);
//     t.add(td);

//     struct se {
//                              // [ intervals )
//         char     _;          // 0-1  i8
//         sd       __[13];     // 1-74 i8 76-80 i32 80-81 i8 84-85 i8 88-92 i32 92-93 i8
//         int32_t  ___;
//         sd       ____;
//         sc       _____;
//     };

//     vector<type*> _te = {
//         new type_int8(),
//         new type_array("", td, 13),
//         new type_int32(),
//         td,
//         new type_array("", new type_int8(), 73)
//     };
//     type_struct* te = new type_struct("se", _te);
//     t.add(te);

//     struct sf {
//         struct {
//             sd _[39];
//             int8_t __[7][39];
//         } _;
//         se __[73];
//         struct {
//             int8_t _[7];
//             int16_t __;
//         } ___[39];
//         sd ____;
//     };
    
//     vector<type*> _tf = {
//         new type_struct("", {
//             new type_array("", td, 39),
//             new type_array("", int8_7, 39)
//         }),
//         new type_array("", te, 73),
//         new type_array("", int8_7__int16, 39),
//         td
//     };
//     type_struct* tf = new type_struct("sf", _tf);
//     t.add(tf);

//     struct sg {
//         union {
//             int32_t a;
//             double  b;
//             sf      c;
//         };
//     };

//     vector<type*> _tg = {
//         new type_int32(),
//         new type_r64(),
//         tf
//     };
//     type_union* tg = new type_union("sg", _tg);
//     t.add(tg);

//     union sh {
//         sb _;
//         struct {
//             sc _;
//             sa __;
//             se ___;
//         } __;
//         sd ___;
//         se ____;
//         sf _____;
//     };

//     type_union* th = new type_union("sh", {
//         tb,
//         new type_struct("", {
//             tc,
//             tc,
//             te
//         }),
//         td,
//         te,
//         tf
//     });
//     t.add(th);

//     struct si {
//         sh _;
//         sc __;
//         sd ___;
//         se ____;
//         sg _____;
//     };

//     type_struct* ti = new type_struct("si", {
//         th,
//         tc,
//         td,
//         te,
//         tg
//     });
//     t.add(ti);

//     union sj {
//         sa _;
//         sc __[902];
//         se ___;
//     } ___;

//     type_union* tj = new type_union("sj", {
//         ta,
//         new type_array("", tc, 902),
//         te
//     });
//     t.add(tj);

//     struct sk {
//         si _;
//         sd __[39];
//         sj ___;
//     };

//     vector<type*> _tk = {
//         ti,
//         new type_array("", td, 39),
//         tj
//     };
//     type_struct* tk = new type_struct("sk", _tk);
//     t.add(tk);

//     constexpr uint32_t sl_alignedness = 1024;
//     struct sl {
//         sj _[32]; // arr of unions
//         union {
//             sk _[50];
//             sj __[39];
//         } __;
//     } __attribute__ ((aligned (sl_alignedness)));

//     type_struct* tl = new type_struct("sl", {
//         new type_array("", tj, 32),
//         new type_union("", {
//             new type_array("", tk, 50),
//             new type_array("", tj, 39)
//         })
//     });
//     t.add(tl);
//     tl->set_alignment(sl_alignedness);

//     constexpr uint32_t sm_alignedness = 4096;

// #pragma pack(push)
// #pragma pack(1)
//     struct sm {
//         sa _[1];
//         sb __[2];
//         sc ___[3];
//         sd ____[4];
//         se _____[5];
//         sf ______[6];
//         sg _______[7];
//         sh ________[8];
//         si _________[9];
//         sj __________[10];
//         sk ___________[11];
//         sl ____________[12];
//     } __attribute__ ((aligned (sm_alignedness)));
// #pragma pack(pop)

//     type_struct* tm = new type_struct("sm", {
//         new type_array("", ta, 1),
//         new type_array("", tb, 2),
//         new type_array("", tc, 3),
//         new type_array("", td, 4),
//         new type_array("", te, 5),
//         new type_array("", tf, 6),
//         new type_array("", tg, 7),
//         new type_array("", th, 8),
//         new type_array("", ti, 9),
//         new type_array("", tj, 10),
//         new type_array("", tk, 11),
//         new type_array("", tl, 12)
//     });
//     t.add(tm);
//     tm->set_max_alignment(1);
//     tm->set_alignment(sm_alignedness);

// #pragma pack(push)
// #pragma pack(2)
//     struct sn {
//         sa _[1];
//         sb __[2];
//         sc ___[3];
//         sd ____[4];
//         se _____[5];
//         sf ______[6];
//         sg _______[7];
//         sh ________[8];
//         si _________[9];
//         sj __________[10];
//         sk ___________[11];
//         sl ____________[12];
//     };
// #pragma pack(pop)

//     type_struct* tn = new type_struct("sn", {
//         new type_array("", ta, 1),
//         new type_array("", tb, 2),
//         new type_array("", tc, 3),
//         new type_array("", td, 4),
//         new type_array("", te, 5),
//         new type_array("", tf, 6),
//         new type_array("", tg, 7),
//         new type_array("", th, 8),
//         new type_array("", ti, 9),
//         new type_array("", tj, 10),
//         new type_array("", tk, 11),
//         new type_array("", tl, 12)
//     });
//     t.add(tn);
//     tn->set_max_alignment(2);

//     struct so {
//         struct {
//             int16_t _;
//             int8_t  __;
//         } _;
//         union {
//             int32_t _;
//             int8_t  __;
//             int64_t ___;
//         } __[37];
//         union {
//             int32_t _;
//             int8_t  __;
//             int64_t ___;
//         } *___;
//     } __attribute__ ((aligned (1024)));
//     type_struct* to = new type_struct("so", {
//         new type_struct("", {
//             new type_int16(),
//             new type_int8()
//         }),
//         new type_union("", {
//             new type_array("",
//                 new type_union("", {
//                     new type_int32(),
//                     new type_int8(),
//                     new type_int64()
//                 })
//             , 37),
//             new type_pointer(
//                 new type_union("", {
//                     new type_int32(),
//                     new type_int8(),
//                     new type_int64()
//                 })
//             )
//         })
//     });
//     t.add(to);
//     to->set_alignment(1024);

// #pragma pack(push, 1)
//     struct sp {
//         so _;

//         union {
//             union {
//                 int32_t _;
//                 int8_t  __;
//                 int64_t ___;
//             } __[37];

//             union {
//                 int32_t _;
//                 int8_t  __;
//                 int64_t ___;
//             } *___;
//         } __;
//     };
// #pragma pack()
//     type_struct* tp = new type_struct("sp", {
//         to,
//         new type_union("", {
//             new type_array("",
//                 new type_union("", {
//                     new type_int32(),
//                     new type_int8(),
//                     new type_int64()
//                 })
//             , 37),
//             new type_pointer(
//                 new type_union("", {
//                     new type_int32(),
//                     new type_int8(),
//                     new type_int64()
//                 })
//             )
//         })
//     });
//     t.add(tp);
//     tp->set_max_alignment(1);

//     LOG(sizeof(sa));
//     LOG(alignof(sa));
//     cout << endl;
//     LOG(sizeof(sb));
//     LOG(alignof(sb));
//     cout << endl;
//     LOG(sizeof(sc));
//     LOG(alignof(sc));
//     cout << endl;
//     LOG(sizeof(sd));
//     LOG(alignof(sd));
//     cout << endl;
//     LOG(sizeof(se));
//     LOG(alignof(se));
//     cout << endl;
//     LOG(sizeof(sf));
//     LOG(alignof(sf));
//     cout << endl;
//     LOG(sizeof(sg));
//     LOG(alignof(sg));
//     cout << endl;
//     LOG(sizeof(sh));
//     LOG(alignof(sh));
//     cout << endl;
//     LOG(sizeof(si));
//     LOG(alignof(si));
//     cout << endl;
//     LOG(sizeof(sj));
//     LOG(alignof(sj));
//     cout << endl;
//     LOG(sizeof(sk));
//     LOG(alignof(sk));
//     cout << endl;
//     LOG(sizeof(sl));
//     LOG(alignof(sl));
//     cout << endl;
//     LOG(sizeof(sm));
//     LOG(alignof(sm));
//     cout << endl;
//     LOG(sizeof(sn));
//     LOG(alignof(sn));
//     cout << endl;
//     LOG(sizeof(so));
//     LOG(alignof(so));
//     cout << endl;
//     LOG(sizeof(sp));
//     LOG(alignof(sp));
//     cout << endl;

//     FILE* fp = fopen("types2.txt", "w");
//     // FILE* fp = stdout;
//     t.print_all(fp);
//     fclose(fp);

//     ASSERT(sizeof(sa) == ta->sizeof_total());
//     ASSERT(alignof(sa) == ta->alignment());
//     ASSERT(sizeof(sb) == tb->sizeof_total());
//     ASSERT(alignof(sb) == tb->alignment());
//     ASSERT(sizeof(sc) == tc->sizeof_total());
//     ASSERT(alignof(sc) == tc->alignment());
//     ASSERT(sizeof(sd) == td->sizeof_total());
//     ASSERT(alignof(sd) == td->alignment());
//     ASSERT(sizeof(se) == te->sizeof_total());
//     ASSERT(alignof(se) == te->alignment());
//     ASSERT(sizeof(sf) == tf->sizeof_total());
//     ASSERT(alignof(sf) == tf->alignment());
//     ASSERT(sizeof(sg) == tg->sizeof_total());
//     ASSERT(alignof(sg) == tg->alignment());
//     ASSERT(sizeof(sh) == th->sizeof_total());
//     ASSERT(alignof(sh) == th->alignment());
//     ASSERT(sizeof(si) == ti->sizeof_total());
//     ASSERT(alignof(si) == ti->alignment());
//     ASSERT(sizeof(sj) == tj->sizeof_total());
//     ASSERT(alignof(sj) == tj->alignment());
//     ASSERT(sizeof(sk) == tk->sizeof_total());
//     ASSERT(alignof(sk) == tk->alignment());
//     ASSERT(sizeof(sl) == tl->sizeof_total());
//     ASSERT(alignof(sl) == tl->alignment());
//     ASSERT(sizeof(sm) == tm->sizeof_total());
//     ASSERT(alignof(sm) == tm->alignment());
//     ASSERT(sizeof(sn) == tn->sizeof_total());
//     ASSERT(alignof(sn) == tn->alignment());
//     ASSERT(sizeof(so) == to->sizeof_total());
//     ASSERT(alignof(so) == to->alignment());
//     ASSERT(sizeof(sp) == tp->sizeof_total());
//     ASSERT(alignof(sp) == tp->alignment());

//     return 0;
// }

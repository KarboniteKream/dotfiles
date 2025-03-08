#include QMK_KEYBOARD_H

#define _BL 0
#define _FL 1

enum custom_keycodes {
    MC_KANA = SAFE_RANGE,
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case MC_KANA:
            if (record->event.pressed) {
                SEND_STRING(SS_LALT("`"));
            }

            break;
    }

    return true;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Base Layer
     * .---------------------------------------------------------------.
     * |E`~|1  |2  |3  |4  |5  |6  |7  |8  |9  |0  |-  |=  |Backsp |`~ |
     * |---------------------------------------------------------------|
     * |Tab  |Q  |W  |E  |R  |T  |Y  |U  |I  |O  |P  |[  |]  |\    |Del|
     * |---------------------------------------------------------------|
     * |Fn    |A  |S  |D  |F  |G  |H  |J  |K  |L  |;  |'  |Enter   |PgU|
     * |---------------------------------------------------------------|
     * |Shift   |Z  |X  |C  |V  |B  |N  |M  |,  |.  |/  |Shift |Up |PgD|
     * |---------------------------------------------------------------|
     * |Ctrl|Win |Alt |Space                   |JP |Fn |Ctr|Lft|Dwn|Rgt|
     * '---------------------------------------------------------------'
     */
    [_BL] = LAYOUT_65_ansi(
        KC_GESC, KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_BSPC, KC_GRV,
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSLS, KC_DEL,
        MO(_FL), KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_ENT,  KC_PGUP,
        KC_LSFT,          KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT, KC_UP,   KC_PGDN,
        KC_LCTL, KC_LGUI, KC_LALT,                            KC_SPC,                    MC_KANA, MO(_FL), KC_RCTL, KC_LEFT, KC_DOWN, KC_RGHT
    ),

    /* Function Layer
     * .---------------------------------------------------------------.
     * |`~ |F1 |F2 |F3 |F4 |F5 |F6 |F7 |F8 |F9 |F10|F11|F12|Del    |   |
     * |---------------------------------------------------------------|
     * |     |Prv|Ply|Nxt|   |   |   |   |   |   |PSc|`~ |~  |     |   |
     * |---------------------------------------------------------------|
     * |      |Vl-|Mut|Vl+|   |   |Lft|Dwn|Up |Rgt|   |   |        |Hom|
     * |---------------------------------------------------------------|
     * |        |   |   |   |   |   |   |   |   |   |   |      |   |End|
     * |---------------------------------------------------------------|
     * |    |    |    |                        |   |   |   |   |   |   |
     * '---------------------------------------------------------------'
     */
    [_FL] = LAYOUT_65_ansi(
        KC_GRV , KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_DEL,  _______,
        _______, KC_MPRV, KC_MPLY, KC_MNXT, _______, _______, _______, _______, _______, _______, KC_PSCR, KC_GRV,  KC_TILD, _______, _______,
        _______, KC_VOLD, KC_MUTE, KC_VOLU, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, _______, _______,          _______, KC_HOME,
        _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_END,
        _______, _______, _______,                            _______,                   _______, _______, _______, _______, _______, _______
    ),
};

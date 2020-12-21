<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'username' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'iS$FDcIi;!VkcnX({zUl^K_W]w#CT<fBw_HoiR)G:Zu7;<_@#|F5+^wq2=P8gA-0' );
define( 'SECURE_AUTH_KEY',  '&o)cRRw.|sqF/rvEKNL.#0sPKy2P|k~:j?(_ThdYINby5?8 QgbTm;}Kjn@w}^2h' );
define( 'LOGGED_IN_KEY',    'Qku9i0f_.C&Rs/<X1=64BtVYHTm:~Z@tSPmGs$pz{by@JSNtwh9]I/L|l)R--cdb' );
define( 'NONCE_KEY',        'R+~3@Y5RT8TmUq0i_T&nQ/%Z]=*$:qha-^abM`wfE[^&60[/MzdG@jZfb3Jh)fzg' );
define( 'AUTH_SALT',        'FnF)GmPMQN>,v$PD>?=7^=44TmCc6Br^8?#P2_@sHdL|1b>w7h3M,f/m B&x4u=%' );
define( 'SECURE_AUTH_SALT', 'mrk7PtB,iu-y.lVi,oXRdk,<c#uiwwEhehrFBn.`CgkUX0m+s]U1^:|n&Z[UqXtN' );
define( 'LOGGED_IN_SALT',   'cMa|Gla2_W#aPmnuyr5h3[>>FqLQTN}PwvMNXb$tp73?Orw|gtO1@S1G6PusRf(E' );
define( 'NONCE_SALT',       '0deqFB0:FL?]VI=zQ&=z)G_e3Y4Eq6j~pK#f&9vf( fEw%XX`;Mp@_Bwpa(P*s<E' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en « wp-config.php » et remplir les
 * valeurs.
 *
 * Ce fichier contient les réglages de configuration suivants :
 *
 * Réglages MySQL
 * Préfixe de table
 * Clés secrètes
 * Langue utilisée
 * ABSPATH
 *
 * @link https://fr.wordpress.org/support/article/editing-wp-config-php/.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define( 'DB_NAME', 'ENV_WORDPRESS_MYSQL_DB' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'ENV_WORDPRESS_MYSQL_USR' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'ENV_WORDPRESS_MYSQL_USR_PWD' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', 'ENV_MYSQL_HOST' );

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/**
 * Type de collation de la base de données.
 * N’y touchez que si vous savez ce que vous faites.
 */
define( 'DB_COLLATE', '' );

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clés secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'y[^t~An>XH5tgFo:L2_Xuer:c^B4*eoK,TB~;%u6-[^X#~m/f@8,>faq:IOO3_Gh' );
define( 'SECURE_AUTH_KEY',  'Nl(&UG}m7:wYY4~:CWGjv,?xo% @o 9U=FQoHD`<FI<N#8PE<w;>&D-~mEvg>am}' );
define( 'LOGGED_IN_KEY',    'Zj)>xa%:[:SyHlx1`>neRAP1lZ%zYWCv]325g[& 4,eneeJ[:t?X6J5r)=3ORE][' );
define( 'NONCE_KEY',        '*<x-;nK-.S&]@F&.Z;AEyK`$Q$rmZy OuJ!u]J_m/swbMRanfN,gH`/&R3g#g].7' );
define( 'AUTH_SALT',        'ACJ|la9CGR}+JF+.b&UGD9u~;0lPrYeG5kZ$`xaI_vw{Fl2vvC>Cza%rdt%w:h1:' );
define( 'SECURE_AUTH_SALT', '3UO`Ar+putUFW,16*[P%htFf1tTWe&Wi+UbwY@DR,=D3|O->6Qiw^Zx_V iQr(CK' );
define( 'LOGGED_IN_SALT',   'dr;-K|pQU c53(!},um!xx3Fx[uA}[$#$ygn#kbe.{Qx^1)PH>Ryt)}KpXLkz!@D' );
define( 'NONCE_SALT',       '#kJ/St0*&y^XfxC**@<-Ec,5v>sAjtf072T((GU17j61kk7kQ!Jm{52D%+FfG7m%' );
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortement recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://fr.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( ! defined( 'ABSPATH' ) )
  define( 'ABSPATH', dirname( __FILE__ ) . '/' );

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once( ABSPATH . 'wp-settings.php' );

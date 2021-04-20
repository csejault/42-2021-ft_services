<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en « wp-config.php » et remplir les
 * valeurs.
 *
 * Ce fichier contient les réglages de configuration suivants :
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
define( 'DB_NAME', 'wp_db' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'wp_adm' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'Le mdp de mysql est ceci!' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', '172.17.0.2' );

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
define( 'AUTH_KEY',         'O74[+d=Mgv?~<9RV.8k<468migC48XVW5;KAK:}yb[1=5xdrM,KTt{68[@Gi-1C>' );
define( 'SECURE_AUTH_KEY',  ':tEhi68{n5> BY^u5o%coU06YRujqmhaB>rd6Av!D/B/,Zd%F<Zh*SpwgbhzJar$' );
define( 'LOGGED_IN_KEY',    'Z2H% IL~N//{LeSFxAh=W`4r!t(LI83YHm3wroBlq5Zp2WuM^6!IYk@AbXo`p]T;' );
define( 'NONCE_KEY',        '[PP33xXKr}jaV(g$ Y_@.c_yNM-03}ek!QN:az,)/PDJK=%WFA{(P3|]T$Kz)!;V' );
define( 'AUTH_SALT',        'uj!ZtpCv4qmjRkwB!lVI#&N0GcJy?Kx+POfi?X>zB0|$9r4`yT0h-Dn$?^A{ +}(' );
define( 'SECURE_AUTH_SALT', '*H9>KZZ|c^Z,,b?Yebmz4ye6u3=H(L|ouK3XX/]p{ZGei3>?zir>GFpKeS95Xr[v' );
define( 'LOGGED_IN_SALT',   '+=@i=L`4N*@P/er{DL}v~knYZ7_d@N((%S,l9<9lqQm(>Bh@L1{t(UP3Coib-HL!' );
define( 'NONCE_SALT',       'e|)cu5kGpJw^VF#bsfA%LIu6NR+&ahODFwEg=otd!*J$Pa:>-aQ]2W ] s`^TM&x' );
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
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


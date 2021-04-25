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


/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define( 'DB_NAME', 'ENV_WORDPRESS_MYSQL_DB' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'ENV_WORDPRESS_MYSQL_USR' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'ENV_WORDPRESS_MYSQL_USR_PWD' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', 'ENV_MYSQL_HOST' );

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
define( 'AUTH_KEY',         '2VeSQGl!vT)6x6Bq<vmoV_QamBlu22_:2/%DB1oCG1[rOg8G`U+:&y0G{ziEc@KJ' );
define( 'SECURE_AUTH_KEY',  '/zYi$v TFR:)-!K5_o %;1/&DS4B2]A<.Y6ReA]Df%*8)S*|KF0>gootVG@v#m,e' );
define( 'LOGGED_IN_KEY',    ';)3M;H|`_dC7[wr)pn/]_XZt8Vh<+C#G< Wm3RoMqE}^_[wzAk* ~p/%.qno<6]+' );
define( 'NONCE_KEY',        '5(pG[xJy/8NC[JH@^%XDDml_pJ~:8+tH45@l_LO%(nCJxS*cOd$_$(%K4y+Fc`w3' );
define( 'AUTH_SALT',        '14SMgZegVK G=O.)cCn5s{c6w],GPzyS?uz:*L`>Tum;ex9RFh{s)H:r#rw(T%|}' );
define( 'SECURE_AUTH_SALT', ')3W1Hz}vQo-3F;{%^$_Ra|OLq_.S_OxIj4RQI;R);7zaLJrff@!zD42C09rGa7k3' );
define( 'LOGGED_IN_SALT',   '[=Qnd%>pE^?a<Z6i%8M!i86vXFb)]Y7^*3H(7:lb*v;*(=_pT&j.>O.;+X+KV}%w' );
define( 'NONCE_SALT',       '>1Ov%6Fmwa(4wfV4b,Bm3_fFY$#^YcJ;]KmUb*<XK]f4c:LkEZY/yxjZQ}FBt^t*' );
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

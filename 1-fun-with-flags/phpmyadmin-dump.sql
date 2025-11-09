-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 08, 2025 at 03:11 PM
-- Server version: 5.7.25-0ubuntu0.16.04.2
-- PHP Version: 7.0.33-0ubuntu0.16.04.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `footprintsonthemoon`
--

-- --------------------------------------------------------

--
-- Table structure for table `wp_commentmeta`
--

CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_comments`
--

CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(2, 27, 'kripke', 'kripke@kripke.com', '', '192.168.1.102', '2020-03-04 13:46:52', '2020-03-04 13:46:52', 'I was there and it was boring af! You guys suck!', 0, '1', 'Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0', '', 0, 2),
(3, 23, 'kripke', 'kripke@kripke.com', '', '192.168.1.102', '2020-03-04 13:47:19', '2020-03-04 13:47:19', 'This is pathetic. Im out', 0, '1', 'Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0', '', 0, 2),
(4, 36, 'stuart', 'stuart@stuart.com', '', '192.168.1.102', '2020-03-04 14:06:05', '2020-03-04 14:06:05', 'Guys sorry to bother you here but you never answer my phone calls.  I don\'t know why. Maybe your phones are broken... Anyway your merchandise doesn\'t sell at all. I think I want my money back... or a place to stay...', 0, '1', 'Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0', '', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `wp_links`
--

CREATE TABLE `wp_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_options`
--

CREATE TABLE `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://10.0.0.20/music/wordpress', 'yes'),
(2, 'home', 'http://10.0.0.20/music/wordpress', 'yes'),
(3, 'blogname', 'Footprints on the Moon', 'yes'),
(4, 'blogdescription', 'This is the official website of our Band', 'yes'),
(5, 'users_can_register', '1', 'yes'),
(6, 'admin_email', 'footprintsonthemoon@localhost.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '1', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '1', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'F j, Y', 'yes'),
(24, 'time_format', 'g:i a', 'yes'),
(25, 'links_updated_date_format', 'F j, Y g:i a', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/index.php/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:89:{s:11:"^wp-json/?$";s:22:"index.php?rest_route=/";s:14:"^wp-json/(.*)?";s:33:"index.php?rest_route=/$matches[1]";s:21:"^index.php/wp-json/?$";s:22:"index.php?rest_route=/";s:24:"^index.php/wp-json/(.*)?";s:33:"index.php?rest_route=/$matches[1]";s:57:"index.php/category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:52:"index.php/category/(.+?)/(feed|rdf|rss|rss2|atom)/?$";s:52:"index.php?category_name=$matches[1]&feed=$matches[2]";s:33:"index.php/category/(.+?)/embed/?$";s:46:"index.php?category_name=$matches[1]&embed=true";s:45:"index.php/category/(.+?)/page/?([0-9]{1,})/?$";s:53:"index.php?category_name=$matches[1]&paged=$matches[2]";s:27:"index.php/category/(.+?)/?$";s:35:"index.php?category_name=$matches[1]";s:54:"index.php/tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:49:"index.php/tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?tag=$matches[1]&feed=$matches[2]";s:30:"index.php/tag/([^/]+)/embed/?$";s:36:"index.php?tag=$matches[1]&embed=true";s:42:"index.php/tag/([^/]+)/page/?([0-9]{1,})/?$";s:43:"index.php?tag=$matches[1]&paged=$matches[2]";s:24:"index.php/tag/([^/]+)/?$";s:25:"index.php?tag=$matches[1]";s:55:"index.php/type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:50:"index.php/type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?post_format=$matches[1]&feed=$matches[2]";s:31:"index.php/type/([^/]+)/embed/?$";s:44:"index.php?post_format=$matches[1]&embed=true";s:43:"index.php/type/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?post_format=$matches[1]&paged=$matches[2]";s:25:"index.php/type/([^/]+)/?$";s:33:"index.php?post_format=$matches[1]";s:48:".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$";s:18:"index.php?feed=old";s:20:".*wp-app\\.php(/.*)?$";s:19:"index.php?error=403";s:18:".*wp-register.php$";s:23:"index.php?register=true";s:42:"index.php/feed/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:37:"index.php/(feed|rdf|rss|rss2|atom)/?$";s:27:"index.php?&feed=$matches[1]";s:18:"index.php/embed/?$";s:21:"index.php?&embed=true";s:30:"index.php/page/?([0-9]{1,})/?$";s:28:"index.php?&paged=$matches[1]";s:51:"index.php/comments/feed/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:46:"index.php/comments/(feed|rdf|rss|rss2|atom)/?$";s:42:"index.php?&feed=$matches[1]&withcomments=1";s:27:"index.php/comments/embed/?$";s:21:"index.php?&embed=true";s:54:"index.php/search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:49:"index.php/search/(.+)/(feed|rdf|rss|rss2|atom)/?$";s:40:"index.php?s=$matches[1]&feed=$matches[2]";s:30:"index.php/search/(.+)/embed/?$";s:34:"index.php?s=$matches[1]&embed=true";s:42:"index.php/search/(.+)/page/?([0-9]{1,})/?$";s:41:"index.php?s=$matches[1]&paged=$matches[2]";s:24:"index.php/search/(.+)/?$";s:23:"index.php?s=$matches[1]";s:57:"index.php/author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:52:"index.php/author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:50:"index.php?author_name=$matches[1]&feed=$matches[2]";s:33:"index.php/author/([^/]+)/embed/?$";s:44:"index.php?author_name=$matches[1]&embed=true";s:45:"index.php/author/([^/]+)/page/?([0-9]{1,})/?$";s:51:"index.php?author_name=$matches[1]&paged=$matches[2]";s:27:"index.php/author/([^/]+)/?$";s:33:"index.php?author_name=$matches[1]";s:79:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:74:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:80:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]";s:55:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$";s:74:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true";s:67:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]";s:49:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$";s:63:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]";s:66:"index.php/([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:61:"index.php/([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$";s:64:"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]";s:42:"index.php/([0-9]{4})/([0-9]{1,2})/embed/?$";s:58:"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true";s:54:"index.php/([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]";s:36:"index.php/([0-9]{4})/([0-9]{1,2})/?$";s:47:"index.php?year=$matches[1]&monthnum=$matches[2]";s:53:"index.php/([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:48:"index.php/([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$";s:43:"index.php?year=$matches[1]&feed=$matches[2]";s:29:"index.php/([0-9]{4})/embed/?$";s:37:"index.php?year=$matches[1]&embed=true";s:41:"index.php/([0-9]{4})/page/?([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&paged=$matches[2]";s:23:"index.php/([0-9]{4})/?$";s:26:"index.php?year=$matches[1]";s:68:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:78:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:98:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:93:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:93:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:74:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:63:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$";s:91:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true";s:67:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$";s:85:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1";s:87:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:82:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]";s:75:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]";s:82:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$";s:98:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]";s:71:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$";s:97:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]";s:57:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:67:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:87:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:82:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:82:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:63:"index.php/[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:74:"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:81:"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]";s:61:"index.php/([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$";s:65:"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]";s:48:"index.php/([0-9]{4})/comment-page-([0-9]{1,})/?$";s:44:"index.php?year=$matches[1]&cpage=$matches[2]";s:37:"index.php/.?.+?/attachment/([^/]+)/?$";s:32:"index.php?attachment=$matches[1]";s:47:"index.php/.?.+?/attachment/([^/]+)/trackback/?$";s:37:"index.php?attachment=$matches[1]&tb=1";s:67:"index.php/.?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:62:"index.php/.?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$";s:49:"index.php?attachment=$matches[1]&feed=$matches[2]";s:62:"index.php/.?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$";s:50:"index.php?attachment=$matches[1]&cpage=$matches[2]";s:43:"index.php/.?.+?/attachment/([^/]+)/embed/?$";s:43:"index.php?attachment=$matches[1]&embed=true";s:26:"index.php/(.?.+?)/embed/?$";s:41:"index.php?pagename=$matches[1]&embed=true";s:30:"index.php/(.?.+?)/trackback/?$";s:35:"index.php?pagename=$matches[1]&tb=1";s:50:"index.php/(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:45:"index.php/(.?.+?)/(feed|rdf|rss|rss2|atom)/?$";s:47:"index.php?pagename=$matches[1]&feed=$matches[2]";s:38:"index.php/(.?.+?)/page/?([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&paged=$matches[2]";s:45:"index.php/(.?.+?)/comment-page-([0-9]{1,})/?$";s:48:"index.php?pagename=$matches[1]&cpage=$matches[2]";s:34:"index.php/(.?.+?)(?:/([0-9]+))?/?$";s:47:"index.php?pagename=$matches[1]&page=$matches[2]";}', 'yes'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:1:{i:1;s:33:"reflex-gallery/reflex-gallery.php";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '0', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', '', 'no'),
(40, 'template', 'twentytwenty', 'yes'),
(41, 'stylesheet', 'twentytwenty', 'yes'),
(42, 'comment_whitelist', '1', 'yes'),
(43, 'blacklist_keys', '', 'no'),
(44, 'comment_registration', '0', 'yes'),
(45, 'html_type', 'text/html', 'yes'),
(46, 'use_trackback', '0', 'yes'),
(47, 'default_role', 'subscriber', 'yes'),
(48, 'db_version', '45805', 'yes'),
(49, 'uploads_use_yearmonth_folders', '1', 'yes'),
(50, 'upload_path', '', 'yes'),
(51, 'blog_public', '1', 'yes'),
(52, 'default_link_category', '2', 'yes'),
(53, 'show_on_front', 'posts', 'yes'),
(54, 'tag_base', '', 'yes'),
(55, 'show_avatars', '1', 'yes'),
(56, 'avatar_rating', 'G', 'yes'),
(57, 'upload_url_path', '', 'yes'),
(58, 'thumbnail_size_w', '150', 'yes'),
(59, 'thumbnail_size_h', '150', 'yes'),
(60, 'thumbnail_crop', '1', 'yes'),
(61, 'medium_size_w', '300', 'yes'),
(62, 'medium_size_h', '300', 'yes'),
(63, 'avatar_default', 'mystery', 'yes'),
(64, 'large_size_w', '1024', 'yes'),
(65, 'large_size_h', '1024', 'yes'),
(66, 'image_default_link_type', 'none', 'yes'),
(67, 'image_default_size', '', 'yes'),
(68, 'image_default_align', '', 'yes'),
(69, 'close_comments_for_old_posts', '0', 'yes'),
(70, 'close_comments_days_old', '14', 'yes'),
(71, 'thread_comments', '1', 'yes'),
(72, 'thread_comments_depth', '5', 'yes'),
(73, 'page_comments', '0', 'yes'),
(74, 'comments_per_page', '50', 'yes'),
(75, 'default_comments_page', 'newest', 'yes'),
(76, 'comment_order', 'asc', 'yes'),
(77, 'sticky_posts', 'a:0:{}', 'yes'),
(78, 'widget_categories', 'a:2:{i:2;a:4:{s:5:"title";s:0:"";s:5:"count";i:0;s:12:"hierarchical";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(79, 'widget_text', 'a:3:{i:2;a:4:{s:5:"title";s:15:"About This Site";s:4:"text";s:85:"This may be a good place to introduce yourself and your site or include some credits.";s:6:"filter";b:1;s:6:"visual";b:1;}i:3;a:4:{s:5:"title";s:7:"Find Us";s:4:"text";s:168:"<strong>Address</strong>\n123 Main Street\nNew York, NY 10001\n\n<strong>Hours</strong>\nMonday&mdash;Friday: 9:00AM&ndash;5:00PM\nSaturday &amp; Sunday: 11:00AM&ndash;3:00PM";s:6:"filter";b:1;s:6:"visual";b:1;}s:12:"_multiwidget";i:1;}', 'yes'),
(80, 'widget_rss', 'a:2:{i:1;a:0:{}s:12:"_multiwidget";i:1;}', 'yes'),
(81, 'uninstall_plugins', 'a:0:{}', 'no'),
(82, 'timezone_string', '', 'yes'),
(83, 'page_for_posts', '0', 'yes'),
(84, 'page_on_front', '0', 'yes'),
(85, 'default_post_format', '0', 'yes'),
(86, 'link_manager_enabled', '0', 'yes'),
(87, 'finished_splitting_shared_terms', '1', 'yes'),
(88, 'site_icon', '0', 'yes'),
(89, 'medium_large_size_w', '768', 'yes'),
(90, 'medium_large_size_h', '0', 'yes'),
(91, 'wp_page_for_privacy_policy', '3', 'yes'),
(92, 'show_comments_cookies_opt_in', '1', 'yes'),
(93, 'admin_email_lifespan', '1598880041', 'yes'),
(94, 'initial_db_version', '45805', 'yes'),
(95, 'wp_user_roles', 'a:5:{s:13:"administrator";a:2:{s:4:"name";s:13:"Administrator";s:12:"capabilities";a:61:{s:13:"switch_themes";b:1;s:11:"edit_themes";b:1;s:16:"activate_plugins";b:1;s:12:"edit_plugins";b:1;s:10:"edit_users";b:1;s:10:"edit_files";b:1;s:14:"manage_options";b:1;s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:6:"import";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:8:"level_10";b:1;s:7:"level_9";b:1;s:7:"level_8";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;s:12:"delete_users";b:1;s:12:"create_users";b:1;s:17:"unfiltered_upload";b:1;s:14:"edit_dashboard";b:1;s:14:"update_plugins";b:1;s:14:"delete_plugins";b:1;s:15:"install_plugins";b:1;s:13:"update_themes";b:1;s:14:"install_themes";b:1;s:11:"update_core";b:1;s:10:"list_users";b:1;s:12:"remove_users";b:1;s:13:"promote_users";b:1;s:18:"edit_theme_options";b:1;s:13:"delete_themes";b:1;s:6:"export";b:1;}}s:6:"editor";a:2:{s:4:"name";s:6:"Editor";s:12:"capabilities";a:34:{s:17:"moderate_comments";b:1;s:17:"manage_categories";b:1;s:12:"manage_links";b:1;s:12:"upload_files";b:1;s:15:"unfiltered_html";b:1;s:10:"edit_posts";b:1;s:17:"edit_others_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:10:"edit_pages";b:1;s:4:"read";b:1;s:7:"level_7";b:1;s:7:"level_6";b:1;s:7:"level_5";b:1;s:7:"level_4";b:1;s:7:"level_3";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:17:"edit_others_pages";b:1;s:20:"edit_published_pages";b:1;s:13:"publish_pages";b:1;s:12:"delete_pages";b:1;s:19:"delete_others_pages";b:1;s:22:"delete_published_pages";b:1;s:12:"delete_posts";b:1;s:19:"delete_others_posts";b:1;s:22:"delete_published_posts";b:1;s:20:"delete_private_posts";b:1;s:18:"edit_private_posts";b:1;s:18:"read_private_posts";b:1;s:20:"delete_private_pages";b:1;s:18:"edit_private_pages";b:1;s:18:"read_private_pages";b:1;}}s:6:"author";a:2:{s:4:"name";s:6:"Author";s:12:"capabilities";a:10:{s:12:"upload_files";b:1;s:10:"edit_posts";b:1;s:20:"edit_published_posts";b:1;s:13:"publish_posts";b:1;s:4:"read";b:1;s:7:"level_2";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;s:22:"delete_published_posts";b:1;}}s:11:"contributor";a:2:{s:4:"name";s:11:"Contributor";s:12:"capabilities";a:5:{s:10:"edit_posts";b:1;s:4:"read";b:1;s:7:"level_1";b:1;s:7:"level_0";b:1;s:12:"delete_posts";b:1;}}s:10:"subscriber";a:2:{s:4:"name";s:10:"Subscriber";s:12:"capabilities";a:2:{s:4:"read";b:1;s:7:"level_0";b:1;}}}', 'yes'),
(96, 'fresh_site', '0', 'yes'),
(97, 'widget_search', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(98, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(99, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:"title";s:0:"";s:6:"number";i:5;}s:12:"_multiwidget";i:1;}', 'yes'),
(100, 'widget_archives', 'a:2:{i:2;a:3:{s:5:"title";s:0:"";s:5:"count";i:0;s:8:"dropdown";i:0;}s:12:"_multiwidget";i:1;}', 'yes'),
(101, 'widget_meta', 'a:2:{i:2;a:1:{s:5:"title";s:0:"";}s:12:"_multiwidget";i:1;}', 'yes'),
(102, 'sidebars_widgets', 'a:4:{s:19:"wp_inactive_widgets";a:0:{}s:9:"sidebar-1";a:3:{i:0;s:8:"search-2";i:1;s:14:"recent-posts-2";i:2;s:17:"recent-comments-2";}s:9:"sidebar-2";a:3:{i:0;s:10:"archives-2";i:1;s:12:"categories-2";i:2;s:6:"meta-2";}s:13:"array_version";i:3;}', 'yes'),
(103, 'cron', 'a:4:{i:1762608042;a:5:{s:32:"recovery_mode_clean_expired_keys";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:16:"wp_version_check";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:17:"wp_update_plugins";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:16:"wp_update_themes";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:10:"twicedaily";s:4:"args";a:0:{}s:8:"interval";i:43200;}}s:34:"wp_privacy_delete_old_export_files";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:6:"hourly";s:4:"args";a:0:{}s:8:"interval";i:3600;}}}i:1762608068;a:2:{s:19:"wp_scheduled_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}s:25:"delete_expired_transients";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}i:1762608070;a:1:{s:30:"wp_scheduled_auto_draft_delete";a:1:{s:32:"40cd750bba9870f18aada2478b24840a";a:3:{s:8:"schedule";s:5:"daily";s:4:"args";a:0:{}s:8:"interval";i:86400;}}}s:7:"version";i:2;}', 'yes'),
(104, 'widget_pages', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(105, 'widget_calendar', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(106, 'widget_media_audio', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(107, 'widget_media_image', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(108, 'widget_media_gallery', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(109, 'widget_media_video', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(110, 'widget_tag_cloud', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(111, 'widget_nav_menu', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(112, 'widget_custom_html', 'a:1:{s:12:"_multiwidget";i:1;}', 'yes'),
(114, 'theme_mods_twentytwenty', 'a:1:{s:18:"custom_css_post_id";i:-1;}', 'yes'),
(115, 'recovery_keys', 'a:0:{}', 'yes'),
(116, '_site_transient_update_core', 'O:8:"stdClass":4:{s:7:"updates";a:1:{i:0;O:8:"stdClass":10:{s:8:"response";s:6:"latest";s:8:"download";s:59:"https://downloads.wordpress.org/release/wordpress-5.3.2.zip";s:6:"locale";s:5:"en_US";s:8:"packages";O:8:"stdClass":5:{s:4:"full";s:59:"https://downloads.wordpress.org/release/wordpress-5.3.2.zip";s:10:"no_content";s:70:"https://downloads.wordpress.org/release/wordpress-5.3.2-no-content.zip";s:11:"new_bundled";s:71:"https://downloads.wordpress.org/release/wordpress-5.3.2-new-bundled.zip";s:7:"partial";b:0;s:8:"rollback";b:0;}s:7:"current";s:5:"5.3.2";s:7:"version";s:5:"5.3.2";s:11:"php_version";s:6:"5.6.20";s:13:"mysql_version";s:3:"5.0";s:11:"new_bundled";s:3:"5.3";s:15:"partial_version";s:0:"";}}s:12:"last_checked";i:1762602291;s:15:"version_checked";s:5:"5.3.2";s:12:"translations";a:0:{}}', 'no'),
(121, '_site_transient_update_themes', 'O:8:"stdClass":4:{s:12:"last_checked";i:1762602291;s:7:"checked";a:4:{s:14:"twentynineteen";s:3:"1.4";s:15:"twentyseventeen";s:3:"2.2";s:13:"twentysixteen";s:3:"2.0";s:12:"twentytwenty";s:3:"1.1";}s:8:"response";a:0:{}s:12:"translations";a:0:{}}', 'no'),
(127, 'can_compress_scripts', '0', 'no'),
(147, 'recently_activated', 'a:4:{s:45:"acf-frontend-display/ACF_frontend_display.php";i:1583342896;s:72:"wp-responsive-thumbnail-slider/wp-responsive-images-thumbnail-slider.php";i:1583342894;s:55:"work-the-flow-file-upload/work-the-flow-file-upload.php";i:1583342892;s:27:"site-import/site-import.php";i:1583340604;}', 'yes'),
(158, 'WPLANG', '', 'yes'),
(159, 'new_admin_email', 'footprintsonthemoon@localhost.com', 'yes'),
(177, 'responsive_thumbnail_slider_settings', 'a:14:{s:9:"linkimage";s:1:"1";s:16:"pauseonmouseover";s:1:"1";s:4:"auto";s:0:"";s:5:"speed";s:4:"1000";s:5:"pause";i:1000;s:8:"circular";s:1:"1";s:11:"imageheight";s:3:"120";s:10:"imagewidth";s:3:"120";s:7:"visible";s:1:"5";s:11:"min_visible";s:1:"1";s:6:"scroll";s:1:"1";s:12:"resizeImages";s:1:"1";s:17:"scollerBackground";s:7:"#FFFFFF";s:11:"imageMargin";s:2:"15";}', 'yes'),
(178, 'responsive_thumbnail_slider_messages', 'a:0:{}', 'yes'),
(186, 'wtf-fu_plugin_options', 'a:3:{s:28:"remove_all_data_on_uninstall";s:1:"0";s:20:"include_plugin_style";s:1:"1";s:20:"show_powered_by_link";s:1:"0";}', 'yes'),
(187, 'wtf-fu_upload_default_options', 'a:15:{s:19:"deny_public_uploads";s:1:"1";s:14:"wtf_upload_dir";s:12:"wtf-fu_files";s:17:"wtf_upload_subdir";s:7:"default";s:17:"accept_file_types";s:32:"jpg|jpeg|mpg|mp3|png|gif|wav|ogg";s:17:"inline_file_types";s:32:"jpg|jpeg|mpg|mp3|png|gif|wav|ogg";s:16:"image_file_types";s:16:"gif|jpg|jpeg|png";s:13:"max_file_size";s:1:"5";s:19:"max_number_of_files";s:2:"30";s:11:"auto_orient";s:1:"1";s:20:"create_medium_images";s:1:"0";s:12:"medium_width";s:3:"800";s:13:"medium_height";s:3:"600";s:14:"thumbnail_crop";s:1:"1";s:15:"thumbnail_width";s:2:"80";s:16:"thumbnail_height";s:2:"80";}', 'yes'),
(188, 'wtf-fu_version', '1.2.1', 'yes'),
(191, 'reflex_gallery_options', 'a:2:{i:0;O:14:"ReFlex_Gallery":1:{s:11:"plugin_name";s:33:"reflex-gallery/reflex-gallery.php";}i:1;a:7:{s:15:"thumbnail_width";s:4:"auto";s:16:"thumbnail_height";s:4:"auto";s:12:"hide_overlay";s:5:"false";s:11:"hide_social";s:5:"false";s:5:"style";s:7:"default";s:12:"custom_style";s:0:"";s:17:"thumbnail_dShadow";s:4:"true";}}', 'yes'),
(192, 'reflex_gallery_db_version', 'a:2:{i:0;N;i:1;N;}', 'yes'),
(195, '_site_transient_update_plugins', 'O:8:"stdClass":5:{s:12:"last_checked";i:1762602291;s:7:"checked";a:4:{s:45:"acf-frontend-display/ACF_frontend_display.php";s:5:"2.0.5";s:33:"reflex-gallery/reflex-gallery.php";s:5:"3.1.3";s:72:"wp-responsive-thumbnail-slider/wp-responsive-images-thumbnail-slider.php";s:3:"1.0";s:55:"work-the-flow-file-upload/work-the-flow-file-upload.php";s:5:"1.2.1";}s:8:"response";a:1:{s:33:"reflex-gallery/reflex-gallery.php";O:8:"stdClass":12:{s:2:"id";s:28:"w.org/plugins/reflex-gallery";s:4:"slug";s:14:"reflex-gallery";s:6:"plugin";s:33:"reflex-gallery/reflex-gallery.php";s:11:"new_version";s:5:"3.1.7";s:3:"url";s:45:"https://wordpress.org/plugins/reflex-gallery/";s:7:"package";s:57:"https://downloads.wordpress.org/plugin/reflex-gallery.zip";s:5:"icons";a:1:{s:7:"default";s:58:"https://s.w.org/plugins/geopattern-icon/reflex-gallery.svg";}s:7:"banners";a:0:{}s:11:"banners_rtl";a:0:{}s:6:"tested";s:5:"5.2.5";s:12:"requires_php";b:0;s:13:"compatibility";O:8:"stdClass":0:{}}}s:12:"translations";a:0:{}s:9:"no_update";a:0:{}}', 'no'),
(203, '_site_transient_timeout_theme_roots', '1762604091', 'no'),
(204, '_site_transient_theme_roots', 'a:4:{s:14:"twentynineteen";s:7:"/themes";s:15:"twentyseventeen";s:7:"/themes";s:13:"twentysixteen";s:7:"/themes";s:12:"twentytwenty";s:7:"/themes";}', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `wp_postmeta`
--

CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(2, 3, '_wp_page_template', 'default'),
(12, 12, '_wp_attached_file', '2020/03/1942f919a0f4d393b1c.jpg'),
(13, 12, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:640;s:6:"height";i:427;s:4:"file";s:31:"2020/03/1942f919a0f4d393b1c.jpg";s:5:"sizes";a:2:{s:6:"medium";a:4:{s:4:"file";s:31:"1942f919a0f4d393b1c-300x200.jpg";s:5:"width";i:300;s:6:"height";i:200;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:31:"1942f919a0f4d393b1c-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(14, 13, '_wp_attached_file', '2020/03/5692462_0.jpg'),
(15, 13, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:630;s:6:"height";i:630;s:4:"file";s:21:"2020/03/5692462_0.jpg";s:5:"sizes";a:2:{s:6:"medium";a:4:{s:4:"file";s:21:"5692462_0-300x300.jpg";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:21:"5692462_0-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(16, 14, '_wp_attached_file', '2020/03/10308068_764680120327155_381863404237642335_n.jpg'),
(17, 14, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:960;s:6:"height";i:356;s:4:"file";s:57:"2020/03/10308068_764680120327155_381863404237642335_n.jpg";s:5:"sizes";a:3:{s:6:"medium";a:4:{s:4:"file";s:57:"10308068_764680120327155_381863404237642335_n-300x111.jpg";s:5:"width";i:300;s:6:"height";i:111;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:57:"10308068_764680120327155_381863404237642335_n-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:57:"10308068_764680120327155_381863404237642335_n-768x285.jpg";s:5:"width";i:768;s:6:"height";i:285;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(18, 15, '_wp_attached_file', '2020/03/DTNgjT2V4AAYRq0.jpg'),
(19, 15, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1200;s:6:"height";i:833;s:4:"file";s:27:"2020/03/DTNgjT2V4AAYRq0.jpg";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:27:"DTNgjT2V4AAYRq0-300x208.jpg";s:5:"width";i:300;s:6:"height";i:208;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:28:"DTNgjT2V4AAYRq0-1024x711.jpg";s:5:"width";i:1024;s:6:"height";i:711;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:27:"DTNgjT2V4AAYRq0-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:27:"DTNgjT2V4AAYRq0-768x533.jpg";s:5:"width";i:768;s:6:"height";i:533;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(20, 16, '_wp_attached_file', '2020/03/maxresdefault.jpg'),
(21, 16, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:25:"2020/03/maxresdefault.jpg";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:25:"maxresdefault-300x169.jpg";s:5:"width";i:300;s:6:"height";i:169;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:26:"maxresdefault-1024x576.jpg";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:25:"maxresdefault-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:25:"maxresdefault-768x432.jpg";s:5:"width";i:768;s:6:"height";i:432;s:9:"mime-type";s:10:"image/jpeg";}s:14:"post-thumbnail";a:4:{s:4:"file";s:26:"maxresdefault-1200x675.jpg";s:5:"width";i:1200;s:6:"height";i:675;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(22, 17, '_wp_attached_file', '2020/03/Tj15.png'),
(23, 17, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:755;s:6:"height";i:382;s:4:"file";s:16:"2020/03/Tj15.png";s:5:"sizes";a:2:{s:6:"medium";a:4:{s:4:"file";s:16:"Tj15-300x152.png";s:5:"width";i:300;s:6:"height";i:152;s:9:"mime-type";s:9:"image/png";}s:9:"thumbnail";a:4:{s:4:"file";s:16:"Tj15-150x150.png";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:9:"image/png";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(31, 20, '_wp_attached_file', '2020/03/DTNgjT2V4AAYRq0-1.jpg'),
(32, 20, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1200;s:6:"height";i:833;s:4:"file";s:29:"2020/03/DTNgjT2V4AAYRq0-1.jpg";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-1-300x208.jpg";s:5:"width";i:300;s:6:"height";i:208;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:30:"DTNgjT2V4AAYRq0-1-1024x711.jpg";s:5:"width";i:1024;s:6:"height";i:711;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-1-768x533.jpg";s:5:"width";i:768;s:6:"height";i:533;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(40, 23, '_edit_lock', '1583329154:1'),
(41, 24, '_wp_attached_file', '2020/03/DTNgjT2V4AAYRq0-2.jpg'),
(42, 24, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1200;s:6:"height";i:833;s:4:"file";s:29:"2020/03/DTNgjT2V4AAYRq0-2.jpg";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-2-300x208.jpg";s:5:"width";i:300;s:6:"height";i:208;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:30:"DTNgjT2V4AAYRq0-2-1024x711.jpg";s:5:"width";i:1024;s:6:"height";i:711;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-2-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-2-768x533.jpg";s:5:"width";i:768;s:6:"height";i:533;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(43, 25, '_wp_attached_file', '2020/03/DTNgjT2V4AAYRq0-3.jpg'),
(44, 25, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1200;s:6:"height";i:833;s:4:"file";s:29:"2020/03/DTNgjT2V4AAYRq0-3.jpg";s:5:"sizes";a:4:{s:6:"medium";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-3-300x208.jpg";s:5:"width";i:300;s:6:"height";i:208;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:30:"DTNgjT2V4AAYRq0-3-1024x711.jpg";s:5:"width";i:1024;s:6:"height";i:711;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-3-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:29:"DTNgjT2V4AAYRq0-3-768x533.jpg";s:5:"width";i:768;s:6:"height";i:533;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(47, 23, '_thumbnail_id', '25'),
(48, 27, '_edit_lock', '1583329266:1'),
(49, 28, '_wp_attached_file', '2020/03/maxresdefault-1.jpg'),
(50, 28, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:1280;s:6:"height";i:720;s:4:"file";s:27:"2020/03/maxresdefault-1.jpg";s:5:"sizes";a:5:{s:6:"medium";a:4:{s:4:"file";s:27:"maxresdefault-1-300x169.jpg";s:5:"width";i:300;s:6:"height";i:169;s:9:"mime-type";s:10:"image/jpeg";}s:5:"large";a:4:{s:4:"file";s:28:"maxresdefault-1-1024x576.jpg";s:5:"width";i:1024;s:6:"height";i:576;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:27:"maxresdefault-1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}s:12:"medium_large";a:4:{s:4:"file";s:27:"maxresdefault-1-768x432.jpg";s:5:"width";i:768;s:6:"height";i:432;s:9:"mime-type";s:10:"image/jpeg";}s:14:"post-thumbnail";a:4:{s:4:"file";s:28:"maxresdefault-1-1200x675.jpg";s:5:"width";i:1200;s:6:"height";i:675;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}'),
(53, 27, '_oembed_effa815df82f1498c3b40bf0e24ef675', '<iframe title="Thor &amp; Dr. Jones" width="580" height="326" src="https://www.youtube.com/embed/07ke-AdKdqE?feature=oembed" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
(54, 27, '_oembed_time_effa815df82f1498c3b40bf0e24ef675', '1583329390'),
(55, 30, '_edit_lock', '1583334282:1'),
(56, 30, '_oembed_27d53f155d2295649f9afd9d9510d601', '<iframe title="Justin Bieber - Baby ft. Ludacris (Official Music Video)" width="580" height="435" src="https://www.youtube.com/embed/kffacxfA7G4?feature=oembed" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
(57, 30, '_oembed_time_27d53f155d2295649f9afd9d9510d601', '1583334266'),
(58, 30, '_oembed_4b79f7f9749d9f7a08752def63ab1e82', '<iframe title="Katy Perry - Roar (Official)" width="580" height="326" src="https://www.youtube.com/embed/CevxZvSJLk8?feature=oembed" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
(59, 30, '_oembed_time_4b79f7f9749d9f7a08752def63ab1e82', '1583329985'),
(60, 36, '_edit_lock', '1583330513:1'),
(61, 37, '_wp_attached_file', '2020/03/5692462_0-1.jpg'),
(62, 37, '_wp_attachment_metadata', 'a:5:{s:5:"width";i:630;s:6:"height";i:630;s:4:"file";s:23:"2020/03/5692462_0-1.jpg";s:5:"sizes";a:2:{s:6:"medium";a:4:{s:4:"file";s:23:"5692462_0-1-300x300.jpg";s:5:"width";i:300;s:6:"height";i:300;s:9:"mime-type";s:10:"image/jpeg";}s:9:"thumbnail";a:4:{s:4:"file";s:23:"5692462_0-1-150x150.jpg";s:5:"width";i:150;s:6:"height";i:150;s:9:"mime-type";s:10:"image/jpeg";}}s:10:"image_meta";a:12:{s:8:"aperture";s:1:"0";s:6:"credit";s:0:"";s:6:"camera";s:0:"";s:7:"caption";s:0:"";s:17:"created_timestamp";s:1:"0";s:9:"copyright";s:0:"";s:12:"focal_length";s:1:"0";s:3:"iso";s:1:"0";s:13:"shutter_speed";s:1:"0";s:5:"title";s:0:"";s:11:"orientation";s:1:"0";s:8:"keywords";a:0:{}}}');

-- --------------------------------------------------------

--
-- Table structure for table `wp_posts`
--

CREATE TABLE `wp_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(3, 1, '2020-03-04 13:20:42', '2020-03-04 13:20:42', '<!-- wp:heading --><h2>Who we are</h2><!-- /wp:heading --><!-- wp:paragraph --><p>Our website address is: http://192.168.1.105/music/wordpress.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>What personal data we collect and why we collect it</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Comments</h3><!-- /wp:heading --><!-- wp:paragraph --><p>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Media</h3><!-- /wp:heading --><!-- wp:paragraph --><p>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Contact forms</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Cookies</h3><!-- /wp:heading --><!-- wp:paragraph --><p>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Embedded content from other websites</h3><!-- /wp:heading --><!-- wp:paragraph --><p>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p><!-- /wp:paragraph --><!-- wp:heading {"level":3} --><h3>Analytics</h3><!-- /wp:heading --><!-- wp:heading --><h2>Who we share your data with</h2><!-- /wp:heading --><!-- wp:heading --><h2>How long we retain your data</h2><!-- /wp:heading --><!-- wp:paragraph --><p>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p><!-- /wp:paragraph --><!-- wp:paragraph --><p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>What rights you have over your data</h2><!-- /wp:heading --><!-- wp:paragraph --><p>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Where we send your data</h2><!-- /wp:heading --><!-- wp:paragraph --><p>Visitor comments may be checked through an automated spam detection service.</p><!-- /wp:paragraph --><!-- wp:heading --><h2>Your contact information</h2><!-- /wp:heading --><!-- wp:heading --><h2>Additional information</h2><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>How we protect your data</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>What data breach procedures we have in place</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>What third parties we receive data from</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>What automated decision making and/or profiling we do with user data</h3><!-- /wp:heading --><!-- wp:heading {"level":3} --><h3>Industry regulatory disclosure requirements</h3><!-- /wp:heading -->', 'Privacy Policy', '', 'draft', 'closed', 'open', '', 'privacy-policy', '', '', '2020-03-04 13:20:42', '2020-03-04 13:20:42', '', 0, 'http://192.168.1.105/music/wordpress/?page_id=3', 0, 'page', '', 0),
(12, 1, '2020-03-04 13:35:17', '2020-03-04 13:35:17', '', '1942f919a0f4d393b1c', '', 'inherit', 'open', 'closed', '', '1942f919a0f4d393b1c', '', '', '2020-03-04 13:35:17', '2020-03-04 13:35:17', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/1942f919a0f4d393b1c.jpg', 0, 'attachment', 'image/jpeg', 0),
(13, 1, '2020-03-04 13:35:25', '2020-03-04 13:35:25', '', '5692462_0', '', 'inherit', 'open', 'closed', '', '5692462_0', '', '', '2020-03-04 13:35:25', '2020-03-04 13:35:25', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/5692462_0.jpg', 0, 'attachment', 'image/jpeg', 0),
(14, 1, '2020-03-04 13:35:36', '2020-03-04 13:35:36', '', '10308068_764680120327155_381863404237642335_n', '', 'inherit', 'open', 'closed', '', '10308068_764680120327155_381863404237642335_n', '', '', '2020-03-04 13:35:36', '2020-03-04 13:35:36', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/10308068_764680120327155_381863404237642335_n.jpg', 0, 'attachment', 'image/jpeg', 0),
(15, 1, '2020-03-04 13:35:37', '2020-03-04 13:35:37', '', 'DTNgjT2V4AAYRq0', '', 'inherit', 'open', 'closed', '', 'dtngjt2v4aayrq0', '', '', '2020-03-04 13:35:37', '2020-03-04 13:35:37', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0.jpg', 0, 'attachment', 'image/jpeg', 0),
(16, 1, '2020-03-04 13:35:37', '2020-03-04 13:35:37', '', 'maxresdefault', '', 'inherit', 'open', 'closed', '', 'maxresdefault', '', '', '2020-03-04 13:35:37', '2020-03-04 13:35:37', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/maxresdefault.jpg', 0, 'attachment', 'image/jpeg', 0),
(17, 1, '2020-03-04 13:35:38', '2020-03-04 13:35:38', '', 'Tj15', '', 'inherit', 'open', 'closed', '', 'tj15', '', '', '2020-03-04 13:35:38', '2020-03-04 13:35:38', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/Tj15.png', 0, 'attachment', 'image/png', 0),
(20, 1, '2020-03-04 13:38:34', '2020-03-04 13:38:34', '', 'DTNgjT2V4AAYRq0-1', '', 'inherit', 'open', 'closed', '', 'dtngjt2v4aayrq0-1', '', '', '2020-03-04 13:38:34', '2020-03-04 13:38:34', '', 0, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0-1.jpg', 0, 'attachment', 'image/jpeg', 0),
(23, 1, '2020-03-04 13:41:34', '2020-03-04 13:41:34', '<!-- wp:image {"id":24,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0-2-1024x711.jpg" alt="" class="wp-image-24"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p>The band was formed when <a href="https://bigbangtheory.fandom.com/wiki/Raj">Raj</a> and <a href="https://bigbangtheory.fandom.com/wiki/Howard">Howard</a> were hanging out at the <a href="https://bigbangtheory.fandom.com/wiki/Comic_Book_Store">Comic Book Store</a> and <a href="https://bigbangtheory.fandom.com/wiki/Stuart">Stuart</a>\n was looking to add live music to the store and was wondering if they \nknew some musicians if hopes of possibly getting them to play there. \nHoward started musing about how he always wanted to start a band. The \nname, "Footprints on the Moon", was one that Howard had dreamed of when \nhe wanted to form a band in middle school. Raj was the one who suggested\n the kind of music they should play: filk music. This is a combination \nof folk music with a Sci-Fi theme. Stuart agreed with that kind of music\n because it sounded exactly like something he would not be expected to \npay for.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>During the composition of their first song, "<a href="https://bigbangtheory.fandom.com/wiki/Thor_and_Dr._Jones">Thor and Dr. Jones</a>", Raj played a little for <a href="https://bigbangtheory.fandom.com/wiki/Emily">Emily</a>.\n Her main criticism was that it was not suitable for dancing. This \ncomment was also made later by Stuart when they had their first gig at \nthe Comic Book Store. Raj suggested that they try to rewrite the music \nto be more suitable for dancing. This set off an argument and they \nbroke-up the band for about a minute. Then they tearfully reunited. \nAfter playing their song at the Comic Book Store, it was obvious that \nnobody liked it.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Raj created a <a href="https://www.facebook.com/Footprints-on-the-moon-795462453914780/">facebook</a> page for the band in "<a href="https://bigbangtheory.fandom.com/wiki/The_Earworm_Reverberation">The Earworm Reverberation</a>".\n (Howard was upset at finding out about the Facebook page because he \nthought they were going to make all the decisions together, but he got \nover it quickly when he discovered that they have a grand total of 1 \nfan. They tracked down their fan and were waiting to see if he would \nrecognize them until the fan did something very gross, and they ran out.\n Ironically as they were leaving, the fan spoke up and started to ask \nthem if they were the band members. They cut him off and assured him \nthey were not as they fled out the door.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>In "<a href="https://bigbangtheory.fandom.com/wiki/The_Solo_Oscillation">The Solo Oscillation</a>"\n Raj and Howard are preparing for a gig at a Bar Mitzvah.  Howard has \nproblems with balancing his responsibilities to his family and to the \nband so he suggests that Raj replace him.  Raj asks <a href="https://bigbangtheory.fandom.com/wiki/Bert_Kibbler">Bert Kibbler</a> to join the band.  <a href="https://bigbangtheory.fandom.com/wiki/Bernadette">Bernadette</a>\n finding that Howard is still no help around the house, plus being \nannoyed that he starts writing an astronaut musical while she tries to \nsleep insists that he go back and rejoin the band.  So now the band has \nthree members.  \n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>The group recorded their new songs, Color Pulse, Ebb &amp; Flow, \nAcid Hues, Muck Warfare, Now or Never, Fest Zest, and Party\'s Over.  \n</p>\n<!-- /wp:paragraph -->', 'History of the Band', '', 'publish', 'open', 'open', '', 'history-of-the-band', '', '', '2020-03-04 13:41:34', '2020-03-04 13:41:34', '', 0, 'http://192.168.1.105/music/wordpress/?p=23', 0, 'post', '', 1),
(24, 1, '2020-03-04 13:40:21', '2020-03-04 13:40:21', '', 'DTNgjT2V4AAYRq0-2', '', 'inherit', 'open', 'closed', '', 'dtngjt2v4aayrq0-2', '', '', '2020-03-04 13:40:21', '2020-03-04 13:40:21', '', 23, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0-2.jpg', 0, 'attachment', 'image/jpeg', 0),
(25, 1, '2020-03-04 13:41:30', '2020-03-04 13:41:30', '', 'DTNgjT2V4AAYRq0', '', 'inherit', 'open', 'closed', '', 'dtngjt2v4aayrq0-3', '', '', '2020-03-04 13:41:30', '2020-03-04 13:41:30', '', 23, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0-3.jpg', 0, 'attachment', 'image/jpeg', 0),
(26, 1, '2020-03-04 13:41:34', '2020-03-04 13:41:34', '<!-- wp:image {"id":24,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/DTNgjT2V4AAYRq0-2-1024x711.jpg" alt="" class="wp-image-24"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p>The band was formed when <a href="https://bigbangtheory.fandom.com/wiki/Raj">Raj</a> and <a href="https://bigbangtheory.fandom.com/wiki/Howard">Howard</a> were hanging out at the <a href="https://bigbangtheory.fandom.com/wiki/Comic_Book_Store">Comic Book Store</a> and <a href="https://bigbangtheory.fandom.com/wiki/Stuart">Stuart</a>\n was looking to add live music to the store and was wondering if they \nknew some musicians if hopes of possibly getting them to play there. \nHoward started musing about how he always wanted to start a band. The \nname, "Footprints on the Moon", was one that Howard had dreamed of when \nhe wanted to form a band in middle school. Raj was the one who suggested\n the kind of music they should play: filk music. This is a combination \nof folk music with a Sci-Fi theme. Stuart agreed with that kind of music\n because it sounded exactly like something he would not be expected to \npay for.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>During the composition of their first song, "<a href="https://bigbangtheory.fandom.com/wiki/Thor_and_Dr._Jones">Thor and Dr. Jones</a>", Raj played a little for <a href="https://bigbangtheory.fandom.com/wiki/Emily">Emily</a>.\n Her main criticism was that it was not suitable for dancing. This \ncomment was also made later by Stuart when they had their first gig at \nthe Comic Book Store. Raj suggested that they try to rewrite the music \nto be more suitable for dancing. This set off an argument and they \nbroke-up the band for about a minute. Then they tearfully reunited. \nAfter playing their song at the Comic Book Store, it was obvious that \nnobody liked it.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Raj created a <a href="https://www.facebook.com/Footprints-on-the-moon-795462453914780/">facebook</a> page for the band in "<a href="https://bigbangtheory.fandom.com/wiki/The_Earworm_Reverberation">The Earworm Reverberation</a>".\n (Howard was upset at finding out about the Facebook page because he \nthought they were going to make all the decisions together, but he got \nover it quickly when he discovered that they have a grand total of 1 \nfan. They tracked down their fan and were waiting to see if he would \nrecognize them until the fan did something very gross, and they ran out.\n Ironically as they were leaving, the fan spoke up and started to ask \nthem if they were the band members. They cut him off and assured him \nthey were not as they fled out the door.\n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>In "<a href="https://bigbangtheory.fandom.com/wiki/The_Solo_Oscillation">The Solo Oscillation</a>"\n Raj and Howard are preparing for a gig at a Bar Mitzvah.  Howard has \nproblems with balancing his responsibilities to his family and to the \nband so he suggests that Raj replace him.  Raj asks <a href="https://bigbangtheory.fandom.com/wiki/Bert_Kibbler">Bert Kibbler</a> to join the band.  <a href="https://bigbangtheory.fandom.com/wiki/Bernadette">Bernadette</a>\n finding that Howard is still no help around the house, plus being \nannoyed that he starts writing an astronaut musical while she tries to \nsleep insists that he go back and rejoin the band.  So now the band has \nthree members.  \n</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>The group recorded their new songs, Color Pulse, Ebb &amp; Flow, \nAcid Hues, Muck Warfare, Now or Never, Fest Zest, and Party\'s Over.  \n</p>\n<!-- /wp:paragraph -->', 'History of the Band', '', 'inherit', 'closed', 'closed', '', '23-revision-v1', '', '', '2020-03-04 13:41:34', '2020-03-04 13:41:34', '', 23, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/23-revision-v1/', 0, 'revision', '', 0),
(27, 1, '2020-03-04 13:43:09', '2020-03-04 13:43:09', '<!-- wp:paragraph -->\n<p>This is our first song! Enjoy<br>Live from the comic book store! Thank you everyone</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:image {"id":28,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/maxresdefault-1-1024x576.jpg" alt="" class="wp-image-28"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=07ke-AdKdqE","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=07ke-AdKdqE\n</div></figure>\n<!-- /wp:core-embed/youtube -->', 'Thor & Dr. Jones', '', 'publish', 'open', 'open', '', 'thor-dr-jones', '', '', '2020-03-04 13:43:09', '2020-03-04 13:43:09', '', 0, 'http://192.168.1.105/music/wordpress/?p=27', 0, 'post', '', 1),
(28, 1, '2020-03-04 13:42:32', '2020-03-04 13:42:32', '', 'maxresdefault-1', '', 'inherit', 'open', 'closed', '', 'maxresdefault-1', '', '', '2020-03-04 13:42:32', '2020-03-04 13:42:32', '', 27, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/maxresdefault-1.jpg', 0, 'attachment', 'image/jpeg', 0),
(29, 1, '2020-03-04 13:43:09', '2020-03-04 13:43:09', '<!-- wp:paragraph -->\n<p>This is our first song! Enjoy<br>Live from the comic book store! Thank you everyone</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:image {"id":28,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/maxresdefault-1-1024x576.jpg" alt="" class="wp-image-28"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=07ke-AdKdqE","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=07ke-AdKdqE\n</div></figure>\n<!-- /wp:core-embed/youtube -->', 'Thor & Dr. Jones', '', 'inherit', 'closed', 'closed', '', '27-revision-v1', '', '', '2020-03-04 13:43:09', '2020-03-04 13:43:09', '', 27, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/27-revision-v1/', 0, 'revision', '', 0),
(30, 1, '2020-03-04 13:49:27', '2020-03-04 13:49:27', '<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=CevxZvSJLk8","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=CevxZvSJLk8\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=kffacxfA7G4","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-4-3 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-4-3 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=kffacxfA7G4\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:paragraph -->\n<p>FLAG-raz{40d17a74e28a62eac2df19e206f0987c}</p>\n<!-- /wp:paragraph -->', 'Secret notes', '', 'private', 'closed', 'closed', '', 'secret-notes', '', '', '2020-03-04 15:04:50', '2020-03-04 15:04:50', '', 0, 'http://192.168.1.105/music/wordpress/?page_id=30', 0, 'page', '', 0),
(31, 1, '2020-03-04 13:49:27', '2020-03-04 13:49:27', '', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 13:49:27', '2020-03-04 13:49:27', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0),
(32, 1, '2020-03-04 13:49:36', '2020-03-04 13:49:36', '', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 13:49:36', '2020-03-04 13:49:36', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0),
(33, 1, '2020-03-04 13:50:17', '2020-03-04 13:50:17', '', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 13:50:17', '2020-03-04 13:50:17', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0),
(35, 1, '2020-03-04 13:53:05', '2020-03-04 13:53:05', '', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 13:53:05', '2020-03-04 13:53:05', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0),
(36, 1, '2020-03-04 14:04:12', '2020-03-04 14:04:12', '<!-- wp:image {"id":37,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/5692462_0-1.jpg" alt="" class="wp-image-37"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p>From now on you can buy our merchandise exclusively from Stuarts comic book store here on Pasadena. </p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will get 50% discount if you bring a girl with you.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will get a 100% if you are an actual girl.</p>\n<!-- /wp:paragraph -->', 'Buy our merchandise', '', 'publish', 'open', 'open', '', 'buy-our-merchandise', '', '', '2020-03-04 14:04:12', '2020-03-04 14:04:12', '', 0, 'http://192.168.1.105/music/wordpress/?p=36', 0, 'post', '', 1),
(37, 1, '2020-03-04 13:53:49', '2020-03-04 13:53:49', '', '5692462_0-1', '', 'inherit', 'open', 'closed', '', '5692462_0-1', '', '', '2020-03-04 13:53:49', '2020-03-04 13:53:49', '', 36, 'http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/5692462_0-1.jpg', 0, 'attachment', 'image/jpeg', 0),
(38, 1, '2020-03-04 14:04:12', '2020-03-04 14:04:12', '<!-- wp:image {"id":37,"sizeSlug":"large"} -->\n<figure class="wp-block-image size-large"><img src="http://192.168.1.105/music/wordpress/wp-content/uploads/2020/03/5692462_0-1.jpg" alt="" class="wp-image-37"/></figure>\n<!-- /wp:image -->\n\n<!-- wp:paragraph -->\n<p>From now on you can buy our merchandise exclusively from Stuarts comic book store here on Pasadena. </p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will get 50% discount if you bring a girl with you.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will get a 100% if you are an actual girl.</p>\n<!-- /wp:paragraph -->', 'Buy our merchandise', '', 'inherit', 'closed', 'closed', '', '36-revision-v1', '', '', '2020-03-04 14:04:12', '2020-03-04 14:04:12', '', 36, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/36-revision-v1/', 0, 'revision', '', 0),
(39, 1, '2020-03-04 15:04:50', '2020-03-04 15:04:50', '<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=CevxZvSJLk8","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=CevxZvSJLk8\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:core-embed/youtube {"url":"https://www.youtube.com/watch?v=kffacxfA7G4","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-4-3 wp-has-aspect-ratio"} -->\n<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-4-3 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">\nhttps://www.youtube.com/watch?v=kffacxfA7G4\n</div></figure>\n<!-- /wp:core-embed/youtube -->\n\n<!-- wp:paragraph -->\n<p>FLAG-raz{40d17a74e28a62eac2df19e206f0987c}</p>\n<!-- /wp:paragraph -->', 'Secret notes', '', 'inherit', 'closed', 'closed', '', '30-revision-v1', '', '', '2020-03-04 15:04:50', '2020-03-04 15:04:50', '', 30, 'http://192.168.1.105/music/wordpress/index.php/2020/03/04/30-revision-v1/', 0, 'revision', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_reflex_gallery`
--

CREATE TABLE `wp_reflex_gallery` (
  `Id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `thumbwidth` int(11) DEFAULT NULL,
  `thumbheight` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_reflex_gallery_images`
--

CREATE TABLE `wp_reflex_gallery_images` (
  `Id` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `imagePath` longtext NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `sortOrder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_responsive_thumbnail_slider`
--

CREATE TABLE `wp_responsive_thumbnail_slider` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(1000) NOT NULL,
  `image_name` varchar(500) NOT NULL,
  `createdon` datetime NOT NULL,
  `custom_link` varchar(1000) DEFAULT NULL,
  `post_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wp_termmeta`
--

CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_terms`
--

CREATE TABLE `wp_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, 'Uncategorized', 'uncategorized', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_term_relationships`
--

CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(23, 1, 0),
(27, 1, 0),
(36, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_term_taxonomy`
--

CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `wp_usermeta`
--

CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_usermeta`
--

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'nickname', 'footprintsonthemoon'),
(2, 1, 'first_name', ''),
(3, 1, 'last_name', ''),
(4, 1, 'description', ''),
(5, 1, 'rich_editing', 'true'),
(6, 1, 'syntax_highlighting', 'true'),
(7, 1, 'comment_shortcuts', 'false'),
(8, 1, 'admin_color', 'fresh'),
(9, 1, 'use_ssl', '0'),
(10, 1, 'show_admin_bar_front', 'true'),
(11, 1, 'locale', ''),
(12, 1, 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}'),
(13, 1, 'wp_user_level', '10'),
(14, 1, 'dismissed_wp_pointers', ''),
(15, 1, 'show_welcome_panel', '1'),
(17, 1, 'wp_dashboard_quick_press_last_post_id', '4'),
(18, 1, 'community-events-location', 'a:1:{s:2:"ip";s:11:"192.168.1.0";}'),
(19, 1, 'wp_user-settings', 'libraryContent=browse'),
(20, 1, 'wp_user-settings-time', '1583329295'),
(21, 2, 'nickname', 'kripke'),
(22, 2, 'first_name', ''),
(23, 2, 'last_name', ''),
(24, 2, 'description', ''),
(25, 2, 'rich_editing', 'true'),
(26, 2, 'syntax_highlighting', 'true'),
(27, 2, 'comment_shortcuts', 'false'),
(28, 2, 'admin_color', 'fresh'),
(29, 2, 'use_ssl', '0'),
(30, 2, 'show_admin_bar_front', 'true'),
(31, 2, 'locale', ''),
(32, 2, 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'),
(33, 2, 'wp_user_level', '0'),
(34, 2, 'default_password_nag', ''),
(38, 3, 'nickname', 'stuart'),
(39, 3, 'first_name', ''),
(40, 3, 'last_name', ''),
(41, 3, 'description', ''),
(42, 3, 'rich_editing', 'true'),
(43, 3, 'syntax_highlighting', 'true'),
(44, 3, 'comment_shortcuts', 'false'),
(45, 3, 'admin_color', 'fresh'),
(46, 3, 'use_ssl', '0'),
(47, 3, 'show_admin_bar_front', 'true'),
(48, 3, 'locale', ''),
(49, 3, 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'),
(50, 3, 'wp_user_level', '0'),
(51, 3, 'default_password_nag', ''),
(57, 3, 'wp_dashboard_quick_press_last_post_id', '41'),
(58, 3, 'community-events-location', 'a:1:{s:2:"ip";s:11:"192.168.1.0";}'),
(62, 3, 'session_tokens', 'a:1:{s:64:"e20280251b7ea911cd937d87cbaf8cdc4a9845dade552d869a4adf00dfcc270b";a:4:{s:10:"expiration";i:1583514959;s:2:"ip";s:13:"192.168.1.102";s:2:"ua";s:68:"Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0";s:5:"login";i:1583342159;}}'),
(63, 4, 'nickname', 'x0x0h'),
(64, 4, 'first_name', ''),
(65, 4, 'last_name', ''),
(66, 4, 'description', ''),
(67, 4, 'rich_editing', 'true'),
(68, 4, 'syntax_highlighting', 'true'),
(69, 4, 'comment_shortcuts', 'false'),
(70, 4, 'admin_color', 'fresh'),
(71, 4, 'use_ssl', '0'),
(72, 4, 'show_admin_bar_front', 'true'),
(73, 4, 'locale', ''),
(74, 4, 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'),
(75, 4, 'wp_user_level', '0'),
(76, 4, 'default_password_nag', '1'),
(77, 5, 'nickname', 'rpcf'),
(78, 5, 'first_name', ''),
(79, 5, 'last_name', ''),
(80, 5, 'description', ''),
(81, 5, 'rich_editing', 'true'),
(82, 5, 'syntax_highlighting', 'true'),
(83, 5, 'comment_shortcuts', 'false'),
(84, 5, 'admin_color', 'fresh'),
(85, 5, 'use_ssl', '0'),
(86, 5, 'show_admin_bar_front', 'true'),
(87, 5, 'locale', ''),
(88, 5, 'wp_capabilities', 'a:1:{s:10:"subscriber";b:1;}'),
(89, 5, 'wp_user_level', '0'),
(90, 5, 'default_password_nag', '1');

-- --------------------------------------------------------

--
-- Table structure for table `wp_users`
--

CREATE TABLE `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wp_users`
--

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'footprintsonthemoon', '$P$BFLeWWEe.4pVHfJB6s6P6.0c6nYctc/', 'footprintsonthemoon', 'footprintsonthemoon@localhost.com', '', '2020-03-04 13:20:41', '', 0, 'footprintsonthemoon'),
(2, 'kripke', '$P$BDKbtgEvH7gYy.WN/yHpgXCuxDPxRz/', 'kripke', 'kripke@kripke.com', '', '2020-03-04 13:44:57', '1583329498:$P$B/6Ncexoc9g3tJOggQJvo2/npr5WHw0', 0, 'kripke'),
(3, 'stuart', '$P$BpHBwNm3fHTK28WUvZThgDmIJkmZrY/', 'stuart', 'stuart@stuart.com', '', '2020-03-04 13:48:30', '1583329711:$P$BJbz3KB.OSQUCk/cZjlGFNrXAxJe7B1', 0, 'stuart'),
(4, 'x0x0h', '$P$BdBND2hx24TFD6wD6Vv/wstNqTzfXg1', 'x0x0h', 'zaiqpouhjizegyraef@nesopf.com', '', '2025-11-08 11:53:49', '1762602829:$P$BAYE7cTn.BRylmBjlI.T5vLgrBIKTD.', 0, 'x0x0h'),
(5, 'rpcf', '$P$BlxWwxH50Tg1eHW/KVeNjFPTLS5J8d.', 'rpcf', 'r@gmail.com', '', '2025-11-08 12:54:45', '1762606485:$P$Bl6n0qG0zx.xKHXVU8wXTUpr.2enCD1', 0, 'rpcf');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_comments`
--
ALTER TABLE `wp_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- Indexes for table `wp_links`
--
ALTER TABLE `wp_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indexes for table `wp_options`
--
ALTER TABLE `wp_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`),
  ADD KEY `autoload` (`autoload`);

--
-- Indexes for table `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_posts`
--
ALTER TABLE `wp_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);

--
-- Indexes for table `wp_reflex_gallery`
--
ALTER TABLE `wp_reflex_gallery`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `wp_reflex_gallery_images`
--
ALTER TABLE `wp_reflex_gallery_images`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `wp_responsive_thumbnail_slider`
--
ALTER TABLE `wp_responsive_thumbnail_slider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_terms`
--
ALTER TABLE `wp_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indexes for table `wp_term_relationships`
--
ALTER TABLE `wp_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indexes for table `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_users`
--
ALTER TABLE `wp_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_comments`
--
ALTER TABLE `wp_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `wp_links`
--
ALTER TABLE `wp_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_options`
--
ALTER TABLE `wp_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;
--
-- AUTO_INCREMENT for table `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
--
-- AUTO_INCREMENT for table `wp_posts`
--
ALTER TABLE `wp_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `wp_reflex_gallery`
--
ALTER TABLE `wp_reflex_gallery`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_reflex_gallery_images`
--
ALTER TABLE `wp_reflex_gallery_images`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_responsive_thumbnail_slider`
--
ALTER TABLE `wp_responsive_thumbnail_slider`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wp_terms`
--
ALTER TABLE `wp_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `wp_users`
--
ALTER TABLE `wp_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

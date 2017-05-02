<?php

/*
types:
adblock -> ||sub.domain.com^
url -> http://sub.domain.com
domains with paths will be skipped to avoid false positives
*/

class Parser
{
	private $lists;
	private $domains;

	function __construct()
	{
		$this->lists = array();
		$this->domains = array();
	}

	public
	function pushList($name, $param, $url, $type, $allowpath = false)
	{
		array_push($this->lists, array(
			"name" => $name,
			"param" => $param,
			"url" => $url,
			"type" => $type,
			"allowpath" => $allowpath
		));
	}

	public
	function run($param, $allowpath = false)
	{
		$num = 0;
		foreach($this->lists as & $list)
		{
			if (($param == $list["param"]) || ($param == "all"))
			{
				switch ($list["type"])
				{
				case "adblock":
					array_push($this->domains, "#" . $list["name"]);
					$this->parseAdblock($list["url"], "||", "^", $allowpath);
					$num++;
					break;

				case "url":
					array_push($this->domains, "#" . $list["name"]);
					$this->parseList($list["url"], $allowpath);
					$num++;
					break;

				default:
					break;
				}

				if ($param != "all") break;
			}
		}

		return $num;
	}

	public
	function countList()
	{
		return count($this->domains);
	}

	public
	function printList($before, $after)
	{
		$domains = array_unique($this->domains);
		foreach($this->domains as & $domain)
		{
			echo $before . $domain . $after;;
		}
	}

	private
	function parseList($url, $allowpath)
	{
		$data = file_get_contents($url);
		$lines = explode("\n", $data);
		foreach($lines as & $line)
		{
			$line = $this->_trim($line);
			if (substr($line, 0, 1) == "#") continue; //skip comment
			if ($this->_containsIP($line)) continue;
			if ($domain = $this->_extractDomain($line))
			{
				if (!$this->_hasPath($domain) || $allowpath)
				{
					array_push($this->domains, $this->_trimPath($domain));
				}
			}
		}
	}

	private
	function parseAdblock($url, $start, $end, $allowpath)
	{
		$data = file_get_contents($url);
		$lines = explode("\n", $data);
		foreach($lines as & $line)
		{
			$line = $this->_trim($line);
			if (substr($line, 0, 1) == "#") continue; //skip comment
			if ($this->_containsIP($line)) continue;
			if (substr_count($line, $end) > 1) continue; //fix for ||twitter.com^*/scribe^ and similar

			if ((substr($line, 0, strlen($start)) == $start) && (substr($line, (strlen($end) * -1)) == $end))
			{
				if ($domain = $this->_extractDomain($line))
				{
					if (!$this->_hasPath($domain) || $allowpath)
					{
						array_push($this->domains, $this->_trimPath($domain));
					}
				}
			}
		}
	}

	private
	function _containsIP($str)
	{
		return preg_match("/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/", $str, $ip);
	}

	private
	function _trim($str)
	{
		return rtrim(trim(strtolower($str)) , "/"); //lowercase, remove all whitespaces, trim slash at the end
	}

	private
	function _extractDomain($str)
	{
		if (preg_match("#([a-z0-9_~-]+\.)+[a-z]{2,}(\/\S*)?#i", $str, $domain)) //extract domain + path
		{
			return $domain[0];
		}
		else return false;
	}

	private
	function _hasPath($str)
	{
		if (strpos($str, "/") == 0)
		{
			return false;
		}
		else return true;
	}

	private
	function _trimPath($str)
	{
		$pos = strpos($str, "/");
		if($pos)
		{
			return substr($str, 0, $pos);
		} else return $str;
	}
}


if (isset($_GET["list"])) //all param may will time out
{
	$parser = new Parser();

	/* name, param, url, type allowpath (optional) */
	$parser->pushList("Anti-PopAds", "antipopads", "https://raw.githubusercontent.com/Yhonay/antipopads/master/popads.txt", "adblock");
	$parser->pushList("Adware Filters", "adware_filters", "https://easylist-downloads.adblockplus.org/adwarefilters.txt", "adblock");
	$parser->pushList("EasyPrivacy + EasyList", "easyprivacy_easylist", "https://easylist-downloads.adblockplus.org/adwarefilters.txt", "adblock");
	$parser->pushList("Adguard DNS Filter", "adguard_dns", "https://adguard.com/en/filter-rules.html?id=15", "adblock");
	$parser->pushList("Fanboys Ultimate List", "fanboy_ultimate", "https://fanboy.co.nz/r/fanboy-ultimate.txt", "adblock");
	$parser->pushList("Blockzilla", "blockzilla", "https://raw.githubusercontent.com/zpacman/Blockzilla/master/Blockzilla.txt", "adblock");
	$parser->pushList("Openpish", "openpish", "https://openphish.com/feed.txt", "url");
	$parser->pushList("Malware URLs", "malwareurls", "http://malwareurls.joxeankoret.com/normal.txt", "url");
	$parser->pushList("Adguard Mobile Ads Filter", "adguard_mobile", "https://adguard.com/en/filter-rules.html?id=11", "adblock");
	$parser->pushList("EasyList Germany", "easylist_de", "https://easylist-downloads.adblockplus.org/easylistgermany.txt", "adblock");
	$parser->pushList("Adguard English", "adguard_en", "https://adguard.com/en/filter-rules.html?id=2", "adblock");
	$parser->pushList("Adguard German", "adguard_de", "https://adguard.com/en/filter-rules.html?id=6", "adblock");

	$allowpath = false;

	//will lead to tons of wrongfully blocked domains
	if (isset($_GET["allowpath"])) $allowpath = true;

	if($parser->run($_GET["list"], $allowpath) > 0)
	{
		$parser->printList("", "\n");
	} else die("#error, requested list not found");
}
else
{
	die("#error, no arguments given");
}

?>

<?php

class Vault
{
	protected $server;

	function __construct()
	{
		$this->server = substr($_ENV['VAULT_PORT'], 6);
		echo $this->server;
	}

	public function request($path)
	{
		$ch = curl_init();

		$opts = [
			CURLOPT_URL => $this->server.$path,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_HEADER => false,
		];

		curl_setopt_array($ch, $opts);

		$response = curl_exec($ch);

		if (!$response) {
			echo curl_error($ch);
		}

		return $response;
	}
}

$vault = new Vault();

echo $vault->request('/v1/secret/foo');


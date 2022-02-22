<?php

namespace PlusClouds\Core\Database\Traits;

use _PHPStan_e04cc8dfb\Nette\Neon\Exception;
use Bravo3\SSH\Connection;
use Bravo3\SSH\Credentials\PasswordCredential;

/*
 * This trait creates SSH Connections
 */

trait SSHable
{
    public function performSSHCommand(string $command)
    {
        $connection = $this->createSSHConnection();

        $result = trim($connection->execute($command)->getOutput());

        $connection->disconnect();
        return $result;
    }

    /**
     * @throws \Throwable
     */
    public function createSSHConnection(): Connection
    {

        throw_if(
            is_null($this->ip_addr) || is_null($this->password),
            new Exception("Cannot create an SSH Connection. Insufficient Fields in Model.")
        );

        $auth = new PasswordCredential($this->username, $this->password);

        $connection = new Connection(
            $this->ip_addr,
            22, $auth);

        if (!$connection->connect()) {
            throw new \Exception('Error connecting to repo server');
        }

        if (!$connection->authenticate()) {
            throw new \Exception('Error authenticating on repose server');
        }
        return $connection;
    }
}

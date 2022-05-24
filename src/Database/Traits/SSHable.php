<?php

namespace PlusClouds\Core\Database\Traits;

use Bravo3\SSH\Connection;
use Bravo3\SSH\Credentials\PasswordCredential;
use PlusClouds\Core\Exceptions\CannotConnectWithSSHException;

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
            new CannotConnectWithSSHException("Cannot create an SSH Connection. IP Address and Password information is missing.")
        );

        $auth = new PasswordCredential($this->username, $this->password);

        $connection = new Connection(
            $this->ip_addr,
            22, $auth);

        if (!$connection->connect()) {
            throw new CannotConnectWithSSHException('Error connecting to the linux machine');
        }

        if (!$connection->authenticate()) {
            throw new CannotConnectWithSSHException('Error authenticating to the linux machine');
        }

        return $connection;
    }
}
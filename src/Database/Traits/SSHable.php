<?php

namespace PlusClouds\Core\Database\Traits;

use Bravo3\SSH\Connection;
use Bravo3\SSH\Credentials\PasswordCredential;
use PlusClouds\Core\Common\Logger\QueueLogger;
use PlusClouds\Core\Exceptions\CannotConnectWithSSHException;
use PlusClouds\Ip\Database\Models\Ip;

/*
 * This trait creates SSH Connections
 */

trait SSHable
{
    public function performSSHCommand(string $command, QueueLogger $logger = null)
    {
        $connection = $this->createSSHConnection($logger);

        if (!is_null($logger)) {
            $logger->info("Executing : " . $command);
        }

        $result = trim($connection->execute($command)->getOutput());

        if (!is_null($logger)) {
            $logger->info("Result : " . $result);
        }

        $connection->disconnect();

        return $result;
    }

    public function performSSHCommands(array $commands, QueueLogger $logger = null)
    {
        $connection = $this->createSSHConnection($logger);

        $result = "";

        foreach ($commands as $command) {
            if (!is_null($logger)) {
                $logger->info("Executing " . $command);
            }

            $result = trim($connection->execute($command)->getOutput());

            if (!is_null($logger)) {
                $logger->info("Result: $result");
            }
        }

        $connection->disconnect();
        return $result;
    }

    /**
     * @throws \Throwable
     */
    public function createSSHConnection(QueueLogger $logger = null): Connection
    {
        $ipAddr = null;

        if ("PlusClouds\IAAS\Database\Models\VirtualMachine" == get_class($this)
            &&
            $this->virtualNetworkCards->count() > 0
        ) {
            $networkCard = $this->virtualNetworkCards[0];
            $ip = Ip::where("virtual_network_card_id", $networkCard->id)->where('is_reachable', true)->first();

            $this->ip_addr = $ip->ip_addr;
        }
        throw_if(
            is_null($this->ip_addr) || is_null($this->password),
            new CannotConnectWithSSHException("Cannot create an SSH Connection. IP Address and Password information is missing.")
        );

        if (is_null($this->password)) {
            $this->password = "template1";
        }

        if (is_null($this->username)) {
            $this->username = "root";
        }

        $auth = new PasswordCredential($this->username, $this->password);

        $connection = new Connection(
            $this->ip_addr,
            22,
            $auth
        );

        if (!$connection->connect()) {
            throw new CannotConnectWithSSHException('Error connecting to the linux machine');
        }

        if (!is_null($logger)) {
            $logger->info("Created an SSH Connection with " . $this->ip_addr);
        }

        if (!$connection->authenticate()) {
            throw new CannotConnectWithSSHException('Error authenticating to the linux machine');
        }

        return $connection;
    }
}
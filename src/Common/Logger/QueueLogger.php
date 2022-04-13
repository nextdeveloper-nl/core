<?php

namespace PlusClouds\Core\Common\Logger;

class QueueLogger
{
    private $_queueName    = ""; # Which queue we are logging
    private $_functionName = ""; # Targetting element or collection, we will give the ID_ref if one element or model name
    private $_queueTarget  = ""; # Targetting element or collection, we will give the ID_ref if one element or model name

    private $_combinedTag = "";
    public function __construct($queueName,$functionName, $queueTarget)
    {
        $this->_queueName = $queueName;
        $this->_functionName = $functionName;
        $this->_queueTarget = $queueTarget;

        $this->_combinedTag = "[".$queueName."@".$functionName."->".$queueTarget."]";
    }


    function info($message) {
            logger()->info($this->_combinedTag.$message);
    }

    function error($message){
        logger()->error($this->_combinedTag.$message);
    }
}
<?php

namespace Project;

use Perfumer\Framework\Gateway\CompositeGateway;

class Gateway extends CompositeGateway
{
    protected function configure(): void
    {
        $this->addModule('email', null,    null, 'http');
        $this->addModule('email', 'email', null, 'cli');
    }
}

<?php

namespace Email\Module;

use Perfumer\Framework\Controller\Module;

class CommandModule extends Module
{
    public $name = 'email';

    public $router = 'router.console';

    public $request = 'email.request';
}
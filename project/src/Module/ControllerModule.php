<?php

namespace Email\Module;

use Perfumer\Framework\Controller\Module;

class ControllerModule extends Module
{
    public $name = 'email';

    public $router = 'email.router';

    public $request = 'email.request';

    public $components = [
        'view' => 'view.status'
    ];
}
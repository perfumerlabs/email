<?php

namespace Email\Controller;

class SmtpController extends LayoutController
{
    public function post()
    {
        $subject = (string) $this->f('subject');
        $to = (array) $this->f('to');
        $text = (string) $this->f('text');
        $html = (string) $this->f('html');

        $this->validateNotEmpty($subject, 'subject');
        $this->validateString($subject, 'subject');
        $this->validateNotEmptyArray($to, 'to');

        if (!$text && !$html) {
            $this->forward('error', 'badRequest', ["One of \"text\" or \"html\" parameters must be set"]);
        }

        $smtp_host = (string) $this->getContainer()->getParam('smtp/host');
        $smtp_port = (int) $this->getContainer()->getParam('smtp/port');
        $smtp_username = (string) $this->getContainer()->getParam('smtp/username');
        $smtp_password = (string) $this->getContainer()->getParam('smtp/password');
        $smtp_encryption = (string) $this->getContainer()->getParam('smtp/encryption');
        $smtp_timeout = (int) $this->getContainer()->getParam('smtp/timeout');
        $email_from = (string) $this->getContainer()->getParam('email/from');

        $encryption = $smtp_encryption ?: null;

        $transport = (new \Swift_SmtpTransport($smtp_host, $smtp_port, $encryption))
            ->setTimeout($smtp_timeout);

        if ($smtp_username) {
            $transport->setUsername($smtp_username);
        }

        if ($smtp_password) {
            $transport->setPassword($smtp_password);
        }

        $mailer = new \Swift_Mailer($transport);

        $body = $html ?: $text;
        $content_type = $html ? 'text/html' : 'text/plain';

        $message = (new \Swift_Message($subject))
            ->setFrom($email_from)
            ->setTo($to)
            ->setBody($body, $content_type)
        ;

        $sent = $mailer->send($message);

        if ($sent) {
            error_log("Sent \"$subject\"");
        }
    }

    private function validateNotEmpty($var, $name)
    {
        if (!$var) {
            $this->forward('error', 'badRequest', ["\"$name\" parameter must be set"]);
        }
    }

    private function validateString($var, $name)
    {
        if (!is_string($var)) {
            $this->forward('error', 'badRequest', ["\"$name\" parameter is invalid"]);
        }
    }

    private function validateNotEmptyArray($var, $name)
    {
        if (!is_array($var) || count($var) == 0) {
            $this->forward('error', 'badRequest', ["\"$name\" parameter is invalid"]);
        }
    }
}

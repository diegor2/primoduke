
Escrevendo seu primeiro modulo de kernel
========================================
(Writing your first kernel module)

Linux permite escrever módulos de maneira bastante simples e elegante, usando técnicas de orientação a objetos mesmo sendo todo escrito em C. Como a criação de módulos e drives costuma ser feita por fabricantes de hardware, muitos programadores não tem familiaridade com esse assunto ainda que tenham curiosidade de aprender. 

Nessa apresentação serão mostrados os fundamentos sobre módulos, as ferramentas usadas para criá-los e alguns exemplos práticos.

Apresentar o básico sobre drivers (diferença entre character, block e ioctl)
Mostrar o ciclo de vida de um módulo (init, proble, exit, etc..).
Mostrar dispositivos do /dev e os valores de minor e major que os associam ao driver;
Explicar sobre o mecanismo udev.
Apresentar módulo "Hello World" que imprime um log no dmesg
Apresentar um módulo do tipo char usando como base a misc api que aloca memória de kernel e escreve/lê usando echo e cat na linha de comando.

Examples for a talk at FISL15 (International Free Software Forum)

Referencias
-----------

* http://refspecs.linuxfoundation.org/index.shtml
* https://www.kernel.org/doc/Documentation/kbuild/modules.txt
* http://video.linux.com/videos/write-a-real-linux-driver-greg-kh-2008
* http://kernel.org/pub/media/talks/gregkh/2008_driver_writing_tutorial_gregkh.avi
* https://tungsys.wordpress.com/2010/09/02/building-android-aosp-in-debian/
* http://www.techsomnia.net/2012/07/building-android-on-debian-6/
* http://www.debian.org/releases/stable/i386/ch08s06.html.en
* https://www.linux.com/learn/tutorials/39288-how-to-build-latest-linux-kernel-on-debian-from-linus-git-repo
* http://www.kroah.com/linux/talks/ols_2005_driver_tutorial/
* http://lxr.free-electrons.com/source/drivers/usb/serial/ftdi_sio.c
* http://www.tldp.org/LDP/lkmpg/2.6/html/x121.html
* http://kernelbook.sourceforge.net/kernel-api.pdf
* https://www.kernel.org/doc/htmldocs/kernel-api/
* http://www.linux.it/~rubini/docs/misc/misc.html


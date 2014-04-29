#include <linux/kernel.h>
#include <linux/init.h>	
#include <linux/module.h>

/* Função que será chamada quando o modulo é instalado */

static int __init hello_module(void)
{
	printk(KERN_INFO "Hello World!\n");
	return 0;
}

/* Função que será chamada quando o modulo é removido  */

static void __exit goodbye_module(void)
{
	printk(KERN_INFO "adios\n");
}

/* Registra quais funções devem ser chamadas para cada "evento"  */
module_init(hello_module);
module_exit(goodbye_module);

/* Informações sobre o módulo  */

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Diego Ruggeri");
MODULE_DESCRIPTION("Hello World module");

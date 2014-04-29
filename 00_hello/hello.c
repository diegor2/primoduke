#include <linux/kernel.h>
#include <linux/init.h>	
#include <linux/module.h>

static int __init hello_module(void)
{
	printk(KERN_INFO "Hello World!\n");
	return 0;
}

static void __exit goodbye_module(void)
{
	printk(KERN_INFO "adios\n");
}


module_init(hello_module);
module_exit(goodbye_module);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Diego Ruggeri");
MODULE_DESCRIPTION("Hello World module");

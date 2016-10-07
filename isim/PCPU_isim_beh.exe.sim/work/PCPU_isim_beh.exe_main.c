/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000002990652114_2721016330_init();
    work_m_00000000002539594105_2227039234_init();
    work_m_00000000001658579249_3592510781_init();
    work_m_00000000002194923681_0094705538_init();
    work_m_00000000003158879103_2200053187_init();
    work_m_00000000001336777192_3566486687_init();
    work_m_00000000002718854048_2533970755_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002718854048_2533970755");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}

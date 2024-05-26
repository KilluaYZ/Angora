use libc;
use std::{self, env, mem, ops::{Deref, DerefMut}};
use std::mem::size_of;
use libc::setenv;
use crate::config;
use crate::shm::SHM;
use std::sync::Mutex;

// T must be fixed size
pub struct DFG_SHM {
    dfg_shm: SHM<[u32; config::MAX_DFG_MAP_SIZE]>,
    afl_shm: SHM<[u32; config::MAX_MAP_SIZE]>,
}

impl DFG_SHM {
    pub fn new() -> Self {
        // 申请dfg_shm共享内存空间
        let tmp_shm = SHM::<[u32; config::MAX_DFG_MAP_SIZE]>::new();
        env::set_var(config::SHM_ENV_VAR_DFG, tmp_shm.get_id().to_string());
        let mut tmp_ptr = unsafe { *tmp_shm.get_ptr() };
        for i in 0..config::MAX_DFG_MAP_SIZE{
            tmp_ptr[i] = 0;
        }

        //申请afl_shm共享内存空间
        let tmp_afl_shm = SHM::<[u32; config::MAX_MAP_SIZE]>::new();
        env::set_var(config::SHM_ENV_VAR, tmp_afl_shm.get_id().to_string());

        let mut tmp_afl_ptr = unsafe { *tmp_afl_shm.get_ptr() };
        for i in 0..config::MAX_DFG_MAP_SIZE{
            tmp_afl_ptr[i] = 0;
        }

        DFG_SHM {
            dfg_shm: tmp_shm,
            afl_shm: tmp_afl_shm
        }
    }

    pub fn get_score(&self) -> u32{
        let mut score = 0;
        let ptr = unsafe { *self.dfg_shm.get_ptr() };
        for i in 0..config::MAX_DFG_MAP_SIZE{
            score = score + ptr[i];
        };
        score
    }

    pub fn from_id(dfg_id: i32, afl_id: i32) -> Self{
        let tmp_dfg_shm = SHM::<[u32; config::MAX_DFG_MAP_SIZE]>::from_id(dfg_id);
        let tmp_afl_shm = SHM::<[u32; config::MAX_MAP_SIZE]>::from_id(dfg_id);
        DFG_SHM{
            dfg_shm: tmp_dfg_shm,
            afl_shm: tmp_afl_shm
        }
    }
}

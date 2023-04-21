# Copyright (c) Alibaba, Inc. and its affiliates.
import unittest

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f
from medscale.core.auxiliaries.data_builder import get_data
from medscale.core.auxiliaries.utils import setup_seed
from medscale.core.auxiliaries.logging import update_logger
from medscale.core.configs.config import global_cfg
from medscale.core.auxiliaries.runner_builder import get_runner
from medscale.core.auxiliaries.worker_builder import get_server_cls, get_client_cls
<<<<<<< HEAD
=======
=======
from medscale.core.auxiliaries.data_builder import get_data
from medscale.core.auxiliaries.utils import setup_seed
from medscale.core.auxiliaries.logging import update_logger
from medscale.core.configs.config import global_cfg
from medscale.core.auxiliaries.runner_builder import get_runner
from medscale.core.auxiliaries.worker_builder import get_server_cls, get_client_cls
>>>>>>> fe4962455354c9c11afd9c9806ceda28eb280737
>>>>>>> 64b283ee525ef53c32509882719e74890329b83f


class EfficientSimulationTest(unittest.TestCase):
    def setUp(self):
        print(('Testing %s.%s' % (type(self).__name__, self._testMethodName)))

    def test_toy_example_standalone_cmp_sim_impl(self):
        case_cfg = global_cfg.clone()
        case_cfg.merge_from_file('scripts/example_configs/single_process.yaml')

        setup_seed(case_cfg.seed)
        update_logger(case_cfg)

        data, _ = get_data(case_cfg.clone())
        Fed_runner = get_runner(data=data,
                                server_class=get_server_cls(case_cfg),
                                client_class=get_client_cls(case_cfg),
                                config=case_cfg.clone())
        efficient_test_results = Fed_runner.run()

        setup_seed(case_cfg.seed)
        case_cfg.merge_from_list([
            'federate.share_local_model', 'False', 'federate.online_aggr',
            'False'
        ])
        data, _ = get_data(case_cfg.clone())
        Fed_runner = get_runner(data=data,
                                server_class=get_server_cls(case_cfg),
                                client_class=get_client_cls(case_cfg),
                                config=case_cfg.clone())
        ordinary_test_results = Fed_runner.run()
        gap = efficient_test_results["client_summarized_weighted_avg"][
            'test_loss'] - ordinary_test_results[
                "client_summarized_weighted_avg"]['test_loss']
        self.assertLess(gap, 0.1)


if __name__ == '__main__':
    unittest.main()

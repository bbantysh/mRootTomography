% Experiment conditions
dim = 2;
r_true = 1;
nshots = 1e3;
proto_prep = rt_proto_preparation('tetra');
proto_meas = rt_proto_measurement('mub', 'dim', dim);
proto = rt_proto_process(proto_prep, proto_meas);

% Generate state and data
chi_true = rt_randprocess(dim, 'Rank', r_true, 'tracePreserving', false);
clicks = rt_experiment(dim, 'process', 'poiss')...
    .set_data('proto', proto, 'nshots', nshots)...
    .simulate(chi_true);

% Reconstruct process and compare to expected one (the true one in our case)
chi_expected = chi_true;
chi_rec = rt_chi_reconstruct(dim, clicks, proto, nshots, 'Display', 10, 'tracePreserving', false, 'StatType', 'poiss');
Fidelity = rt_fidelity(chi_rec, chi_expected);
fprintf('Fidelity: %.6f\n', Fidelity);
